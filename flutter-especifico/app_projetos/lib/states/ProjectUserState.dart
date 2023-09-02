import 'package:app_projetos/models/UserModel.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class ProjectUserState extends ChangeNotifier {
  String uid;
  ProjectUser? projectUser;
  bool loading = true;

  ProjectUserState({required this.uid}) {
    Stream<ProjectUser?> stream = FirebaseDatabase.instance
        .ref()
        .child('users/$uid')
        .onValue
        .map((event) {
      final Map? data = event.snapshot.value as Map?;
      return data == null ? null : ProjectUser.fromJson(data);
    });

    stream.listen((ProjectUser? newProjectUser) {
      projectUser = newProjectUser;
      loading = false;
      notifyListeners();
    });
  }
}
