import 'package:flutter/material.dart';
import 'Cabecalho.dart';
import 'Corpo.dart';
import 'Contador.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Cabecalho(),
              Corpo(valor: 28),
              Contador(valorInicial: 20),
            ],
          ),
        ),
      ),
    );
  }
}
