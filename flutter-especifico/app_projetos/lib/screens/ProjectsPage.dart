import 'package:app_projetos/models/ProjectModel.dart';
import 'package:app_projetos/models/UserModel.dart';
import 'package:app_projetos/screens/CreateProjectPage.dart';
import 'package:app_projetos/screens/EditProjectPage.dart';
import 'package:app_projetos/screens/EditUserPage.dart';
import 'package:app_projetos/screens/ProfilePage.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import '../utilities/DateTimeFormat.dart';
import '../widgets/ShowProjectUser.dart';

class ProjectsPage extends StatefulWidget {
  ProjectsPage({super.key, required this.uid});
  String uid;

  @override
  State<ProjectsPage> createState() => _ProjectsPageState();
}

class _ProjectsPageState extends State<ProjectsPage> {
  late Stream<ProjectUser?> _projectUserStream;
  late Stream<List<Project>> _projectsStream;
  @override
  void initState() {
    _projectUserStream = FirebaseDatabase.instance
        .ref()
        .child('users')
        .child(widget.uid)
        .onValue
        .map(
      (event) {
        final Map? data = event.snapshot.value as Map?;
        if (data == null) {
          return null;
        }
        return ProjectUser.fromJson(data);
      },
    );
    _projectsStream = FirebaseDatabase.instance
        .ref()
        .child('projects')
        .orderByChild('managerId')
        .equalTo(widget.uid)
        .onValue
        .map(
      (event) {
        final Map? data = event.snapshot.value as Map?;
        if (data == null) {
          return [];
        }
        return data.values
            .map((projectJson) => Project.fromJson(projectJson))
            .toList();
      },
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Projetos'),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProfilePage(uid: widget.uid),
                  ),
                );
              },
              icon: const Icon(Icons.person)),
        ],
      ),
      floatingActionButton: IconButton(
        icon: const Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CreateProjectPage(uid: widget.uid),
            ),
          );
        },
      ),
      body: Container(
        alignment: Alignment.topCenter,
        padding: const EdgeInsets.all(20),
        child: StreamBuilder<ProjectUser?>(
          stream: _projectUserStream,
          builder: (context, snapshot) {
            final ProjectUser? user = snapshot.data;
            if (user == null) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Seus dados ainda não foram cadastrados.',
                    style: TextStyle(fontSize: 18),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (contexto) => EditUserPage(uid: widget.uid),
                        ),
                      );
                    },
                    child: const Text(
                      'Finalize seu cadastro.',
                      style: TextStyle(fontSize: 18),
                    ),
                  )
                ],
              );
            } else {
              return Column(
                children: [
                  StreamBuilder<List<Project>>(
                    stream: _projectsStream,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const CircularProgressIndicator();
                      }
                      final List<Project> projects = snapshot.data!;
                      if (projects.isNotEmpty) {
                        final double deliveredProjects = projects
                                .where((project) => project.delivered)
                                .length /
                            projects.length;
                        return Column(
                          children: [
                            ListTile(
                              leading: const Icon(Icons.bar_chart_outlined),
                              title: Text(
                                  'Projetos gerenciados no momento: ${projects.length}'),
                            ),
                            ListTile(
                              leading: const Icon(Icons.percent_rounded),
                              title: Text(
                                  'Taxa de projetos entregues: ${deliveredProjects * 100}%'),
                            ),
                            ...projects.map((Project project) {
                              bool isLate = !project.delivered &&
                                  project.deliverDate.isBefore(DateTime.now());
                              bool isOngoing = !project.delivered &&
                                  project.deliverDate.isAfter(DateTime.now());
                              //Icone de entrega
                              Icon deliverIcon = () {
                                if (isOngoing) {
                                  return const Icon(Icons.event,
                                      color: Colors.orange);
                                } else if (isLate) {
                                  return const Icon(
                                    Icons.event_busy,
                                    color: Colors.red,
                                  );
                                }
                                return const Icon(Icons.event_available,
                                    color: Colors.green);
                              }();

                              //Texto de entrega
                              String deliverText = () {
                                if (isOngoing) {
                                  Duration difference = project.deliverDate
                                      .difference(DateTime.now());
                                  return 'Entregar em ${difference.inDays} dias';
                                } else if (isLate) {
                                  Duration difference = DateTime.now()
                                      .difference(project.deliverDate);
                                  return 'Atraso de ${difference.inDays} dias';
                                }
                                return 'Entregue';
                              }();

                              return ListTile(
                                title: Text(project.name),
                                leading: deliverIcon,
                                trailing: Text(deliverText),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                        'Quantidade de membros: ${project.membersQuantity}'),
                                    Text(
                                        'Data de entrega: ${dateFormat.format(project.deliverDate)}'),
                                  ],
                                ),
                                enabled: !project.delivered,
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => EditProject(
                                        managerId: user.id,
                                        project: project,
                                      ),
                                    ),
                                  );
                                },
                              );
                            })
                          ],
                        );
                      }
                      return const Text('Sem projetos');
                    },
                  )
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
