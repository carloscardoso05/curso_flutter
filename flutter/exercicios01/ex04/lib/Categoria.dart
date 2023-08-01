import 'package:flutter/material.dart';

class Categoria extends StatelessWidget {
  Categoria({super.key, required this.titulo, required this.receitas});
  final String titulo;
  final List<String> receitas;
  
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: Text(
            titulo,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        for (final String receita in receitas)
          Align(
            alignment: Alignment.topLeft,
            child: Text(
              receita,
              style: const TextStyle(fontSize: 18),
            ),
          )
      ],
    );
  }
}
