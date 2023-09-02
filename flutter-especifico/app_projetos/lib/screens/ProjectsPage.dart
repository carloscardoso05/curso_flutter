import 'package:app_projetos/models/UserModel.dart';
import 'package:app_projetos/states/ProjectUserState.dart';
import 'package:app_projetos/screens/CreateProjectPage.dart';
import 'package:app_projetos/screens/ProfilePage.dart';
import 'package:app_projetos/states/UserState.dart';
import 'package:app_projetos/widgets/IncompleteData.dart';
import 'package:app_projetos/widgets/ProjectsView.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProjectsPage extends StatelessWidget {
  const ProjectsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ProjectUserState>(create: (context) {
      String uid = context.read<UserState>().user!.uid;
      return ProjectUserState(uid: uid);
    }, builder: (context, child) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Projetos'),
          actions: const [ProfileButton()],
        ),
        floatingActionButton: const CreateProjectButton(),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(
            alignment: Alignment.topCenter,
            padding: const EdgeInsets.all(20),
            child: const ProjectUserView(),
          ),
        ),
      );
    });
  }
}

class ProjectUserView extends StatelessWidget {
  const ProjectUserView({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ProjectUserState>(
      builder: (context, state, child) {
        if (state.loading) {
          return const CircularProgressIndicator();
        }
        final ProjectUser? user = state.projectUser;
        return user == null ? const IncompleteData() : const ProjectsView();
      },
    );
  }
}

class CreateProjectButton extends StatelessWidget {
  const CreateProjectButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.add),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const CreateProjectPage(),
          ),
        );
      },
    );
  }
}

class ProfileButton extends StatelessWidget {
  const ProfileButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return const ProfilePage();
            },
          ),
        );
      },
      icon: const Icon(Icons.person),
    );
  }
}
