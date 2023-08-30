import 'package:app_projetos/screens/CreateUserPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  void checkErrors(String code) {
    setState(() {
      _emailError = null;
      _passwordError = null;
      if (code == 'invalid-email') {
        _emailError = 'E-mail inválido';
      } else if (code == 'user-disabled') {
        _emailError = 'Usuário desabilitado';
      } else if (code == 'user-not-found') {
        _emailError = 'Usuário não encontrado';
      } else if (code == 'missing-password') {
        _passwordError = 'Insira a senha';
      } else if (code == 'wrong-password') {
        _passwordError = 'Senha inválida';
      } else {
        _emailError = code;
      }
    });
  }

  void trySigInWithEmailAndPassword() async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: _email, password: _password);
      print('login');
    } on FirebaseAuthException catch (error) {
      final String code = error.code;
      checkErrors(code);
    }
  }

  String _email = '';
  String _password = '';
  String? _emailError;
  String? _passwordError;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fazer Login'),
      ),
      body: Container(
        alignment: Alignment.topCenter,
        padding: const EdgeInsets.all(20),
        child: Column(
          children: <Widget>[
            //Cadastro
            Row(
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
                    child: const Text('Cadastre-se.'))
              ],
            ),
            //E-mail
            TextFormField(
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                labelText: 'E-mail',
                errorText: _emailError,
              ),
              onChanged: (value) => setState(() {
                _email = value;
              }),
            ),
            //Senha
            TextFormField(
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                labelText: 'Senha',
                errorText: _passwordError,
              ),
              onChanged: (value) => setState(() {
                _password = value;
              }),
            ),
            //Botão de login
            ElevatedButton(
              onPressed: () {
                trySigInWithEmailAndPassword();
              },
              child: const Padding(
                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                child: Text(
                  'Entrar',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
          ]
              //Adiciona um espaçamento a todos os elementos da coluna
              .map((Widget widget) => Container(
                    width: 500,
                    padding: const EdgeInsets.only(bottom: 20),
                    child: widget,
                  ))
              .toList(),
        ),
      ),
    );
  }
}
