import 'package:app_projetos/models/ProjectModel.dart';
import 'package:app_projetos/models/UserModel.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class EditProject extends StatefulWidget {
  EditProject({super.key, required this.managerId, required this.project});
  Project project;
  String managerId;

  @override
  State<EditProject> createState() => _EditProjectState();
}

class _EditProjectState extends State<EditProject> {
  late final Stream<List<ProjectUser>> _projectUsersStream;
  late String managerId;
  @override
  void initState() {
    managerId = widget.managerId;
    _projectUsersStream =
        FirebaseDatabase.instance.ref().child('users').onValue.map((event) {
      final Map? projects = event.snapshot.value as Map?;

      if (projects == null) return [];
      return projects.values
          .map((project) => ProjectUser.fromJson(project))
          .toList();
    });
    super.initState();
  }

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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              OutlinedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => StreamBuilder<List<ProjectUser>>(
                        stream: _projectUsersStream,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Container();
                          }
                          final List<ProjectUser> users = snapshot.data!;
                          return StatefulBuilder(builder:
                              (BuildContext context, StateSetter setState) {
                            return AlertDialog(
                              title: const Text('Alterar o gerente do projeto'),
                              content: Container(
                                padding: const EdgeInsets.all(50),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
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
                                              element.id == managerId)
                                          .id,
                                      items: users
                                          .map(
                                            (user) => DropdownMenuItem(
                                              value: user.id,
                                              child: Text(user.name),
                                            ),
                                          )
                                          .toList(),
                                      onChanged: (String? value) {
                                        setState(() {
                                          managerId = value!;
                                          // print(managerId);
                                        });
                                      },
                                    ),
                                    // Text(managerId),
                                  ],
                                ),
                              ),
                              actionsAlignment: MainAxisAlignment.spaceEvenly,
                              actions: [
                                ElevatedButton(
                                  style: const ButtonStyle(
                                    backgroundColor:
                                        MaterialStatePropertyAll(Colors.red),
                                  ),
                                  onPressed: () => Navigator.pop(context),
                                  child: const Text('Cancelar'),
                                ),
                                ElevatedButton(
                                  style: const ButtonStyle(
                                    backgroundColor:
                                        MaterialStatePropertyAll(Colors.blue),
                                  ),
                                  onPressed: () async {
                                    await FirebaseDatabase.instance
                                        .ref()
                                        .child('projects')
                                        .child(widget.project.id)
                                        .update({
                                      'managerId': managerId,
                                    });
                                    Navigator.pop(context);
                                  },
                                  child: const Text('Salvar'),
                                ),
                              ],
                            );
                          });
                        }),
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
            ]
                .map((widget) => Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: widget,
                    ))
                .toList(),
          ),
        ),
      ),
    );
  }
}
