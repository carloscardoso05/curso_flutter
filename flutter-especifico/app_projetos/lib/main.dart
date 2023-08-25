import 'package:app_projetos/firebase_options.dart';
import 'package:app_projetos/screens/ProjectsPage.dart';
import 'package:app_projetos/screens/SignInPage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          User? user = snapshot.data;

          if (user == null) {
            return const SignInPage();
          }
          return ProjectsPage(uid: user.uid);
        },
      ),
    );
  }
}
