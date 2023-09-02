import 'package:app_projetos/models/UserModel.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class ProjectUserListState extends ChangeNotifier {
  List<ProjectUser> projectUserList = [];
  bool loading = true;

  ProjectUserListState() {
    Stream<List<ProjectUser>> stream =
        FirebaseDatabase.instance.ref().child('users').onValue.map((event) {
      final Map? projects = event.snapshot.value as Map?;

      return projects == null
          ? []
          : projects.values
              .map((project) => ProjectUser.fromJson(project))
              .toList();
    });

    stream.listen((newProjectUserList) {
      projectUserList = newProjectUserList;
      loading = false;
      notifyListeners();
    });
  }
}
