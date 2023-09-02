import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserState extends ChangeNotifier {
  User? user;
  bool loading = true;

  UserState() {
    Stream<User?> stream = FirebaseAuth.instance.authStateChanges();
    
    stream.listen((User? newUser) {
      user = newUser;
      loading = false;
      notifyListeners();
    });
  }
}
