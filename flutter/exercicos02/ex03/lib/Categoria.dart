import 'package:flutter/material.dart';

class Categoria extends StatelessWidget {
  Categoria({super.key, required this.titulo, required this.receitas});
  final String titulo;
  final List<String> receitas;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Flexible(
          flex: 2,
          child: Center(
            child: Text(
              titulo,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        for (final String receita in receitas)
          Flexible(
            flex: 1,
            child: Container(
              alignment: Alignment.topLeft,
              constraints: BoxConstraints(minHeight: 100.0),
              margin: const EdgeInsets.symmetric(horizontal: 50),
              child: Text(
                receita,
                style: const TextStyle(fontSize: 18),
              ),
            ),
          )
      ],
    );
  }
}
