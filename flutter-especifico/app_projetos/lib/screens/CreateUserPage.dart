import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CreateUserPage extends StatefulWidget {
  const CreateUserPage({super.key});

  @override
  State<CreateUserPage> createState() => _CreateUserPageState();
}

class _CreateUserPageState extends State<CreateUserPage> {
  void checkErrors(String code) {
    setState(() {
      _emailError = null;
      _passwordError = null;
      if (code == 'invalid-email') {
        _emailError = 'E-mail inválido';
      } else if (code == 'email-already-in-use') {
        _emailError = 'E-mail já está em uso';
      } else if (code == 'missing-email') {
        _emailError = 'Insira o e-mail';
      } else if (code == 'missing-password') {
        _passwordError = 'Insira a senha';
      } else if (code == 'weak-password') {
        _passwordError = 'Senha fraca';
      } else {
        _emailError = code;
      }
    });
  }

  void tryCreateUserWithEmailAndPassword() async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: _email, password: _password);
      if (context.mounted) Navigator.pop(context);
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
        title: const Text('Cadastrar usuário'),
      ),
      body: Container(
        alignment: Alignment.topCenter,
        padding: const EdgeInsets.all(20),
        child: Column(
          children: <Widget>[
            TextField(
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
            TextField(
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                labelText: 'Senha',
                errorText: _passwordError,
              ),
              onChanged: (value) => setState(() {
                _password = value;
              }),
            ),
            //Botão de cadastro
            ElevatedButton(
              onPressed: () {
                tryCreateUserWithEmailAndPassword();
              },
              child: const Padding(
                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                child: Text(
                  'Criar conta',
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
