import 'package:flutter/material.dart';

class Receita extends StatelessWidget {
  const Receita({super.key, required this.receita, required this.icone});
  final String receita;
  final IconData icone;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.max,
          children: [
            Icon(
              size: 50,
              icone,
            ),
            Text(
              receita,
              style: const TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
