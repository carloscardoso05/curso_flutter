import 'package:flutter/material.dart';

class Corpo extends StatefulWidget {
  const Corpo({super.key, required this.valor});
  final int valor;

  @override
  State<Corpo> createState() => _EstadoCorpo();
}

class _EstadoCorpo extends State<Corpo> {
  @override
  Widget build(BuildContext context) {
    return Text('Corpo: ${widget.valor}');
  }
}