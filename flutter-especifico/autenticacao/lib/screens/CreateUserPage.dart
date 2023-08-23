import 'package:autenticacao/screens/HomePage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class CreateUserPage extends StatefulWidget {
  const CreateUserPage({super.key});

  @override
  State<CreateUserPage> createState() => _CreateUserPageState();
}

class _CreateUserPageState extends State<CreateUserPage> {
  String _email = '';
  String _password = '';
  String _confirmPassword = '';
  String _name = '';
  String _birthDay = '';
  bool _active = false;
  String? _emailError;
  String? _passwordError;
  String? _confirmPasswordError;
  String? _nameError;
  String? _birthDayError;

  bool validDate(String date) {
    return _birthDay[2] == '/' &&
        _birthDay[5] == '/' &&
        _birthDay.length == 'dd/mm/aaaa'.length;
  }

  bool validData() {
    return [_nameError, _birthDayError, _confirmPasswordError]
            .every((error) => error == null) &&
        _confirmPassword.isNotEmpty &&
        _name.isNotEmpty &&
        _birthDay.isNotEmpty;
  }

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
            //Email
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
            //Senha
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
            //Confirmar senha
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: TextField(
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  labelText: 'Confirmar senha',
                  errorText: _confirmPasswordError,
                ),
                onChanged: (value) => setState(() {
                  _confirmPassword = value;
                  if (_confirmPassword != _password) {
                    setState(() {
                      _confirmPasswordError = 'As senhas devem ser iguais';
                    });
                  } else {
                    setState(() {
                      _confirmPasswordError = null;
                    });
                  }
                }),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: TextField(
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  labelText: 'Nome',
                  errorText: _nameError,
                ),
                onChanged: (value) => setState(() {
                  _name = value;
                  if (_name.isEmpty) {
                    setState(() {
                      _nameError = 'O nome não pode ser vazio';
                    });
                  } else {
                    setState(() {
                      _nameError = null;
                    });
                  }
                }),
              ),
            ),
            //Data de nascimento
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: TextField(
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  labelText: 'Data de nascimento',
                  hintText: '(dd/mm/aaaa)',
                  errorText: _birthDayError,
                ),
                onChanged: (value) => setState(() {
                  _birthDay = value.trim();
                  if (validDate(_birthDay)) {
                    setState(() {
                      _birthDayError = null;
                    });
                  } else {
                    setState(() {
                      _birthDayError = 'Data inválida';
                    });
                  }
                }),
              ),
            ),
            //Ativo
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Ativo'),
                  Switch(
                    value: _active,
                    onChanged: (value) => setState(() {
                      _active = value;
                    }),
                  ),
                ],
              ),
            ),
            //Botão de cadastro
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: ElevatedButton(
                onPressed: () async {
                  if (!validData()) return;
                  try {
                    await FirebaseAuth.instance.createUserWithEmailAndPassword(
                        email: _email, password: _password);
                    User? user = FirebaseAuth.instance.currentUser;
                    if (user != null) {
                      String uid = user.uid;
                      await FirebaseDatabase.instance
                          .ref()
                          .child('usuarios')
                          .child(uid)
                          .set({
                        'nome': _name,
                        'ativo': _active,
                        'data-nascimento': _birthDay,
                      });
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HomePage(
                            uid: uid,
                          ),
                        ),
                      );
                    }
                  } on FirebaseAuthException catch (error) {
                    final String code = error.code;
                    setState(() {
                      _emailError = null;
                      _passwordError = null;
                      if (code == 'invalid-email') {
                        _emailError = 'E-mail inválido';
                      } else if (code == 'email-already-in-use') {
                        _emailError = 'E-mail já está em uso';
                      } else if (code == 'weak-password') {
                        _passwordError = 'Senha fraca';
                      } else {
                        _emailError = code;
                      }
                    });
                  }
                },
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                  child: Text('Cadastrar'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
