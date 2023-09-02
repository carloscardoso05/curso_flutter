import 'package:app_projetos/models/ProjectModel.dart';
import 'package:app_projetos/models/UserModel.dart';
import 'package:app_projetos/states/EditProjectState.dart';
import 'package:app_projetos/states/ProjectUserListState.dart';
import 'package:app_projetos/states/UserState.dart';
import 'package:app_projetos/widgets/SpacedColumn.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditProject extends StatefulWidget {
  EditProject({super.key, required this.project});
  Project project;

  @override
  State<EditProject> createState() => _EditProjectState();
}

class _EditProjectState extends State<EditProject> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Editar Projeto'),
      ),
      body: Center(
        child: Container(
          width: 300,
          padding: const EdgeInsets.all(20),
          child: SpacedColumn(
            space: const EdgeInsets.only(bottom: 20),
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              OutlinedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return MultiProvider(
                          providers: [
                            ChangeNotifierProvider<EditProjectState>(
                                create: (context) => EditProjectState(
                                    managerId:
                                        context.read<UserState>().user!.uid)),
                            ChangeNotifierProvider<ProjectUserListState>(
                                create: (context) => ProjectUserListState()),
                            ChangeNotifierProvider<UserState>(
                                create: (context) => UserState()),
                          ],
                          builder: (context, child) {
                            return Consumer<ProjectUserListState>(
                                builder: (context, userListState, child) {
                              if (userListState.loading) {
                                return const CircularProgressIndicator();
                              }
                              final List<ProjectUser> users =
                                  userListState.projectUserList;
                              return StatefulBuilder(builder:
                                  (BuildContext context, StateSetter setState) {
                                return Consumer<EditProjectState>(
                                    builder: (context, state, child) {
                                  return AlertDialog(
                                    title: const Text(
                                        'Alterar o gerente do projeto'),
                                    content: Container(
                                      padding: const EdgeInsets.all(50),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          const Padding(
                                            padding: EdgeInsets.only(right: 10),
                                            child: Text(
                                              'Novo gerente',
                                              style: TextStyle(fontSize: 16),
                                            ),
                                          ),
                                          DropdownButton<String>(
                                            value: users
                                                .firstWhere((element) =>
                                                    element.id ==
                                                    state.managerId)
                                                .id,
                                            items: users
                                                .map(
                                                  (user) => DropdownMenuItem(
                                                    value: user.id,
                                                    child: Text(user.name),
                                                  ),
                                                )
                                                .toList(),
                                            onChanged: (String? value) =>
                                                state.setManagerId(value!),
                                          ),
                                        ],
                                      ),
                                    ),
                                    actionsAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    actions: [
                                      ElevatedButton(
                                        style: const ButtonStyle(
                                          backgroundColor:
                                              MaterialStatePropertyAll(
                                                  Colors.red),
                                        ),
                                        onPressed: () => Navigator.pop(context),
                                        child: const Text('Cancelar'),
                                      ),
                                      ElevatedButton(
                                        style: const ButtonStyle(
                                          backgroundColor:
                                              MaterialStatePropertyAll(
                                                  Colors.blue),
                                        ),
                                        onPressed: () async {
                                          await FirebaseDatabase.instance
                                              .ref()
                                              .child('projects')
                                              .child(widget.project.id)
                                              .update({
                                            'managerId': state.managerId,
                                          });
                                          Navigator.pop(context);
                                        },
                                        child: const Text('Salvar'),
                                      ),
                                    ],
                                  );
                                });
                              });
                            });
                          });
                    },
                  );
                },
                child: Container(
                  padding: const EdgeInsets.all(10),
                  child: const Text('Alterar gerente do projeto'),
                ),
              ),
              ElevatedButton(
                onPressed: () async {
                  await FirebaseDatabase.instance
                      .ref()
                      .child('projects')
                      .child(widget.project.id)
                      .update({
                    'delivered': true,
                  });
                  Navigator.pop(context);
                },
                child: Container(
                  width: 200,
                  padding: const EdgeInsets.all(10),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(right: 10),
                        child: Icon(Icons.send),
                      ),
                      Text('Entregar')
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
