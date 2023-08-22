import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'CreateUserPage.dart';

class SigInPage extends StatefulWidget {
  const SigInPage({super.key});

  @override
  State<SigInPage> createState() => _SigInPageState();
}

class _SigInPageState extends State<SigInPage> {
  String _email = '';
  String _password = '';
  String? _emailError;
  String? _passwordError;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: TextField(
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              labelText: 'E-mail',
              errorText: _emailError,
            ),
            onChanged: (value) => setState(() => _email = value),
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
            onChanged: (value) => setState(() => _password = value),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: FilledButton(
            child: const Text('Continuar'),
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
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Ainda não possui uma conta?'),
            TextButton(
              style: const ButtonStyle(
                  backgroundColor:
                      MaterialStatePropertyAll(Colors.transparent)),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => CreateUserPage()));
              },
              child: const Text('Cadastre-se'),
            ),
          ],
        )
      ],
    );
  }
}
