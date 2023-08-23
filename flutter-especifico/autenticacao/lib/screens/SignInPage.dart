import 'package:autenticacao/screens/CreateUserPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  String _email = '';
  String _password = '';
  String? _emailError;
  String? _passwordError;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Fazer Login')),
      body: Container(
        alignment: Alignment.topCenter,
        padding: const EdgeInsets.all(20),
        child: Column(
          // Form das credenciais
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: TextField(
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  labelText: 'E-mail',
                  errorText: _emailError,
                ),
                onChanged: (value) => setState(() {
                  _email = value;
                }),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: TextField(
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  labelText: 'Senha',
                  errorText: _passwordError,
                ),
                onChanged: (value) => setState(() {
                  _password = value;
                }),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: ElevatedButton(
                onPressed: () async {
                  try {
                    await FirebaseAuth.instance.signInWithEmailAndPassword(
                        email: _email, password: _password);
                  } on FirebaseAuthException catch (error) {
                    final String code = error.code;
                    setState(() {
                      _emailError = null;
                      _passwordError = null;
                      if (code == 'invalid-email') {
                        _emailError = 'E-mail inválido';
                      } else if (code == 'user-disabled') {
                        _emailError = 'Usuário desabilitado';
                      } else if (code == 'user-not-found') {
                        _emailError = 'Usuário não encontrado';
                      } else if (code == 'wrong-password') {
                        _passwordError = 'Senha inválida';
                      } else {
                        _emailError = code;
                      }
                    });
                  }
                },
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                  child: Text('Entrar'),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Ainda não possui uma conta?'),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CreateUserPage(),
                        ),
                      );
                    },
                    child: const Text('Cadastre-se'),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
