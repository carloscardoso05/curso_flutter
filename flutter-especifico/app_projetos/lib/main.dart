import 'package:app_projetos/firebase_options.dart';
import 'package:app_projetos/screens/ProjectsPage.dart';
import 'package:app_projetos/screens/SignInPage.dart';
import 'package:app_projetos/states/UserState.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<UserState>(
        create: (context) => UserState(),
        builder: (context, child) {
          return MaterialApp(
            home: Consumer<UserState>(
              builder: (context, userState, child) {
                User? user = userState.user;
                return user == null ? const SignInPage() : const ProjectsPage();
              },
            ),
          );
        });
  }
}
