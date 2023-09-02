import 'package:app_projetos/models/ProjectModel.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class ProjectsState extends ChangeNotifier {
  String uid;
  List<Project> projects = [];
  bool loading = true;

  ProjectsState({required this.uid}) {
    final Stream<List<Project>> stream = FirebaseDatabase.instance
        .ref()
        .child('projects')
        .orderByChild('managerId')
        .equalTo(uid)
        .onValue
        .map((event) {
      final Map? data = event.snapshot.value as Map?;
      return data == null
          ? []
          : data.values
              .map((projectJson) => Project.fromJson(projectJson))
              .toList();
    });

    stream.listen((newProjects) {
      projects = newProjects;
      loading = false;
      notifyListeners();
    });
  }
}
