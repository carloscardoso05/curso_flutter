import 'package:app_projetos/models/UserModel.dart';
import 'package:app_projetos/screens/CreateProjectPage.dart';
import 'package:app_projetos/screens/ProfilePage.dart';
import 'package:app_projetos/widgets/IncompleteData.dart';
import 'package:app_projetos/widgets/ProjectsView.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProjectsPage extends StatelessWidget {
  ProjectsPage({super.key, required this.uid});
  String uid;

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
                    builder: (context) => ProfilePage(uid: uid),
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
              builder: (context) => CreateProjectPage(uid: uid),
            ),
          );
        },
      ),
      body: Container(
        alignment: Alignment.topCenter,
        padding: const EdgeInsets.all(20),
        child: ChangeNotifierProvider(
          create: (context) => _ProjectUserState(uid: uid),
          child: Consumer<_ProjectUserState>(
            builder: (context, state, child) {
              if (state.loading) {
                return const CircularProgressIndicator();
              }
              final ProjectUser? user = state.user;
              if (user == null) {
                return IncompleteData(uid: uid);
              } else {
                return ProjectsView(user: user);
              }
            },
          ),
        ),
      ),
    );
  }
}

class _ProjectUserState extends ChangeNotifier {
  String uid;
  ProjectUser? user;
  bool loading = true;

  _ProjectUserState({required this.uid}) {
    Stream<ProjectUser?> stream = FirebaseDatabase.instance
        .ref()
        .child('users/$uid')
        .onValue
        .map((event) {
      final Map? data = event.snapshot.value as Map?;
      if (data == null) {
        return null;
      }
      return ProjectUser.fromJson(data);
    });

    stream.listen((ProjectUser? newUser) {
      user = newUser;
      loading = false;
      notifyListeners();
    });
  }
}
