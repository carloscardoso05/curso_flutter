import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  String email = '';
  String senha = '';
  String errorText = '';
  UserCredential? credential;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Autenticação')),
        body: Container(
          alignment: Alignment.topCenter,
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: TextField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'E-mail',
                  ),
                  onChanged: (value) => setState(() {
                    email = value;
                  }),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: TextField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Senha',
                  ),
                  onChanged: (value) => setState(() {
                    senha = value;
                  }),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: FilledButton(
                  child: const Text('Continuar'),
                  onPressed: () async {
                    final UserCredential newCredential =
                        await FirebaseAuth.instance.signInWithEmailAndPassword(
                            email: email, password: senha);
                    try {
                      setState(() {
                        credential = newCredential;
                        errorText = '';
                      });
                    } catch (e) {
                      setState(() {
                        errorText = e.toString();
                      });
                    }
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Text(
                    credential?.user?.uid != null ? "Logado" : "Não logado"),
              ),
              if (errorText.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Text('Erro: $errorText'),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
