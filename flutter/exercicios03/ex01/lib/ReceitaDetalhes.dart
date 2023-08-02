import 'package:flutter/material.dart';

class ReceitaDetalhes extends StatelessWidget {
  const ReceitaDetalhes(
      {super.key, required this.receita, required this.detalhes});
  final String receita;
  final String detalhes;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(receita),
      ),
      body: Center(
        child: Column(children: [
          const Text(
            'Detalhes',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(detalhes),
        ]),
      ),
    );
  }
}
