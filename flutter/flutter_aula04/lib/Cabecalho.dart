import 'package:flutter/material.dart';

class Cabecalho extends StatefulWidget {
  const Cabecalho({super.key});

  @override
  State<Cabecalho> createState() => _EstadoCabecalho();
}

class _EstadoCabecalho extends State<Cabecalho> {
  @override
  Widget build(BuildContext context) {
    return const Text('Cabeçalho');
  }
}
