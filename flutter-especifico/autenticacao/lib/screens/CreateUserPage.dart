import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CreateUserPage extends StatefulWidget {
  const CreateUserPage({super.key});

  @override
  State<CreateUserPage> createState() => _CreateUserPageState();
}

class _CreateUserPageState extends State<CreateUserPage> {
  String _email = '';
  String _password = '';
  String? _emailError;
  String? _passwordError;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastro'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
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
                child: const Text('Cadastrar'),
                onPressed: () async {
                  try {
                    await FirebaseAuth.instance.createUserWithEmailAndPassword(
                        email: _email, password: _password);

                    Navigator.pop(context);
                  } on FirebaseAuthException catch (error) {
                    final String code = error.code;

                    setState(() {
                      _emailError = null;
                      _passwordError = null;
                      if (code == 'email-already-in-use') {
                        _emailError = 'E-mail já existente.';
                      } else if (code == 'invalid-email') {
                        _emailError = 'E-mail inválido';
                      } else if (code == 'user-disabled') {
                        _emailError = 'Usuário desabilitado';
                      } else if (code == 'weak-password') {
                        _passwordError = 'Senha fraca';
                      } else {
                        _emailError = code;
                      }
                    });
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
