import 'package:app_projetos/models/UserModel.dart';
import 'package:app_projetos/providers/ProjectUserState.dart';
import 'package:app_projetos/screens/CreateProjectPage.dart';
import 'package:app_projetos/screens/ProfilePage.dart';
import 'package:app_projetos/widgets/IncompleteData.dart';
import 'package:app_projetos/widgets/ProjectsView.dart';
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
        actions: [ProfileButton(uid: uid)],
      ),
      floatingActionButton: CreateProjectButton(uid: uid),
      body: Container(
        alignment: Alignment.topCenter,
        padding: const EdgeInsets.all(20),
        child: ChangeNotifierProvider(
          create: (context) => ProjectUserState(uid: uid),
          child: ProjectUserView(uid: uid),
        ),
      ),
    );
  }
}

class ProjectUserView extends StatelessWidget {
  ProjectUserView({super.key, required this.uid});
  String uid;

  @override
  Widget build(BuildContext context) {
    return Consumer<ProjectUserState>(
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
    );
  }
}

class CreateProjectButton extends StatelessWidget {
  CreateProjectButton({super.key, required this.uid});
  String uid;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.add),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CreateProjectPage(uid: uid),
          ),
        );
      },
    );
  }
}

class ProfileButton extends StatelessWidget {
  ProfileButton({super.key, required this.uid});
  String uid;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return ProfilePage(uid: uid);
            },
          ),
        );
      },
      icon: const Icon(Icons.person),
    );
  }
}