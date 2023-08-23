import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key, required this.uid});
  final String uid;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home'), actions: [
        TextButton(
          child: const Row(children: [
            Text(
              'Sair',
              style: TextStyle(color: Colors.white),
            ),
            Icon(
              Icons.output_rounded,
              color: Colors.white,
            ),
          ]),
          onPressed: () async => await FirebaseAuth.instance.signOut(),
        ),
      ]),
      body: Container(
        alignment: Alignment.topCenter,
        padding: const EdgeInsets.all(20),
        child: StreamBuilder<Map>(
            stream: FirebaseDatabase.instance
                .ref('usuarios/$uid')
                .onValue
                .map((event) => event.snapshot.value as Map),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Text('Carregando...');
              }

              var dados = snapshot.data;

              if (dados == null) {
                return const Text('Dados inexistentes');
              }

              return ListTile(
                leading: Icon(
                  dados['ativo']
                      ? Icons.check_box_rounded
                      : Icons.disabled_by_default_rounded,
                  color: dados['ativo'] ? Colors.green : Colors.red,
                ),
                title: Text(dados['nome']),
                subtitle: Text(dados['data-nascimento']),
              );
            }),
      ),
    );
  }
}
