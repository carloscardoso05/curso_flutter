import 'package:app_projetos/states/ProjectsState.dart';
import 'package:app_projetos/states/UserState.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/ProjectModel.dart';
import '../screens/EditProjectPage.dart';
import '../utilities/DateTimeFormat.dart';

class ProjectsView extends StatelessWidget {
  const ProjectsView({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ProjectsState>(create: (context) {
      String uid = context.read<UserState>().user!.uid;
      return ProjectsState(uid: uid);
    }, builder: (context, child) {
      return Column(
        children: [
          Consumer<ProjectsState>(
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
                              builder: (context) =>
                                  EditProject(project: project),
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
    });
  }
}
