import 'package:app_projetos/models/UserModel.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/ProjectModel.dart';
import '../screens/EditProjectPage.dart';
import '../utilities/DateTimeFormat.dart';

class ProjectsView extends StatelessWidget {
  ProjectsView({super.key, required this.user});
  ProjectUser user;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => _ProjectsState(user: user),
      child: Column(
        children: [
          Consumer<_ProjectsState>(
            builder: (context, state, child) {
              if (state.loading) {
                return const CircularProgressIndicator();
              }

              final List<Project> projects = state.projects;

              if (projects.isNotEmpty) {
                final double deliveredProjects =
                    projects.where((project) => project.delivered).length /
                        projects.length.floor();
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
                          return const Icon(Icons.event, color: Colors.orange);
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
                          Duration difference =
                              project.deliverDate.difference(DateTime.now());
                          return 'Entregar em ${difference.inDays} dias';
                        } else if (isLate) {
                          Duration difference =
                              DateTime.now().difference(project.deliverDate);
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
      ),
    );
  }
}

class _ProjectsState extends ChangeNotifier {
  ProjectUser user;
  List<Project> projects = [];
  bool loading = true;

  _ProjectsState({required this.user}) {
    final Stream<List<Project>> stream = FirebaseDatabase.instance
        .ref()
        .child('projects')
        .orderByChild('managerId')
        .equalTo(user.id)
        .onValue
        .map((event) {
      final Map? data = event.snapshot.value as Map?;
      if (data == null) {
        return [];
      }
      return data.values
          .map((projectJson) => Project.fromJson(projectJson))
          .toList();
    });

    stream.listen((newProjects) {
      projects = newProjects;
      loading = false;
      notifyListeners();
    });
  }
}
