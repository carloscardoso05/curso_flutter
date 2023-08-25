import 'package:app_projetos/models/RolesEnum.dart';
import 'package:app_projetos/models/UserModel.dart';
import 'package:app_projetos/screens/EditUserPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ProjectsPage extends StatefulWidget {
  ProjectsPage({super.key, required this.uid});
  String uid;

  @override
  State<ProjectsPage> createState() => _ProjectsPageState();
}

class _ProjectsPageState extends State<ProjectsPage> {
  late Stream<ProjectUser?> _projectUserStream;
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
        if (data != null) {
          return ProjectUser.fromJson(data);
        } else {
          return null;
        }
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
          TextButton(
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
            },
            child: const Text(
              'Sair',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
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
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: ShowProjectUser(
                      user: user,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        style: const ButtonStyle(
                            backgroundColor:
                                MaterialStatePropertyAll(Colors.red)),
                        onPressed: () async {
                          final DatabaseReference ref = FirebaseDatabase
                              .instance
                              .ref()
                              .child('users')
                              .child(widget.uid);
                          await ref.remove();
                        },
                        child: const Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 12, horizontal: 10),
                          child: Text('Apagar dados'),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  EditUserPage(uid: widget.uid, user: user),
                            ),
                          );
                        },
                        child: const Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 12, horizontal: 10),
                          child: Text('Editar dados'),
                        ),
                      ),
                    ],
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}

class ShowProjectUser extends StatelessWidget {
  final ProjectUser user;
  final DateFormat dateFormat = DateFormat('dd/MM/yyyy');

  ShowProjectUser({
    super.key,
    required this.user,
  });

  Map<Role, String> roles = {
    Role.Desenvolvedor: 'Desenvolvedor',
    Role.Gerente: 'Gerente',
    Role.Testador: 'Testador',
  };

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Nome: ${user.name}',
          style: const TextStyle(fontSize: 16),
        ),
        Text(
          'Cargo: ${roles[user.role]}',
          style: const TextStyle(fontSize: 16),
        ),
        Text(
          'Entrou em: ${dateFormat.format(user.entryDate)}',
          style: const TextStyle(fontSize: 16),
        ),
        Text(
          'Ativo: ${user.active ? "Sim" : "Não"}',
          style: const TextStyle(fontSize: 16),
        ),
      ],
    );
  }
}
