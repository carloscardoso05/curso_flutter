import 'package:app_projetos/models/UserModel.dart';
import 'package:app_projetos/states/ProjectUserState.dart';
import 'package:app_projetos/states/UserState.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/ShowProjectUser.dart';
import 'EditProjectUserPage.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ProjectUserState>(create: (context) {
      String uid = context.read<UserState>().user!.uid;
      return ProjectUserState(uid: uid);
    }, builder: (context, child) {
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
        body: Consumer<ProjectUserState>(
          builder: (context, projectUserState, child) {
            if (projectUserState.loading) {
              return const CircularProgressIndicator();
            }
            final ProjectUser? projectUser = projectUserState.projectUser;
            return projectUser == null
                ? const Text('Usuário não encontrado')
                : Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 20),
                          child: ShowProjectUser(
                            user: projectUser,
                          ),
                        ),
                        Selector<ProjectUserState, ProjectUser>(
                          selector: (context, userState) =>
                              userState.projectUser!,
                          builder: (context, projectUser, child) {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                ElevatedButton(
                                  style: const ButtonStyle(
                                      backgroundColor:
                                          MaterialStatePropertyAll(Colors.red)),
                                  onPressed: () async {
                                    final DatabaseReference ref =
                                        FirebaseDatabase.instance
                                            .ref()
                                            .child('users')
                                            .child(projectUser.id);
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
                                            EditProjectUserPage(
                                          projectUser: projectUser,
                                        ),
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
                            );
                          },
                        ),
                      ],
                    ),
                  );
          },
        ),
      );
    });
  }
}
