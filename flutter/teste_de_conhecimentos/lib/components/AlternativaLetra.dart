import 'package:flutter/material.dart';

class AlternativaLetra extends StatelessWidget {
  const AlternativaLetra({super.key, required this.numeroAlternativa});
  final int numeroAlternativa;
  static const List<String> alternativas = ['A', 'B', 'C', 'D', 'E'];
  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: Container(
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.blue,
        ),
        alignment: Alignment.center,
        child: Text(
          alternativas[numeroAlternativa],
          style: const TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
        ),
      ),
    );
  }
}