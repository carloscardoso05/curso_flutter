import 'package:app_projetos/models/UserModel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import '../widgets/ShowProjectUser.dart';
import 'EditUserPage.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage({super.key, required this.uid});
  String uid;

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
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
        if (data == null) {
          return null;
        }
        return ProjectUser.fromJson(data);
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Conta'),
        actions: [
          TextButton(
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              Navigator.pop(context);
            },
            child: const Text(
              'Sair',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
      body: StreamBuilder<ProjectUser?>(
          stream: _projectUserStream,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            }
            final ProjectUser? user = snapshot.data;
            if (user == null) {
              return const Text('Usuário não encontrado');
            }
            return Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
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
              ),
            );
          }),
    );
  }
}
