import 'package:flutter/material.dart';
import 'ReceitaDetalhes.dart';

class Receita extends StatelessWidget {
  const Receita(
      {super.key,
      required this.titulo,
      required this.icone,
      required this.detalhes});
  final String titulo;
  final String detalhes;
  final IconData icone;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        child: Ink(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.blue.shade500,
          ),
          child: InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      ReceitaDetalhes(titulo: titulo, detalhes: detalhes),
                ),
              );
            },
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Icon(
                    icone,
                    size: 50,
                    color: Colors.white,
                  ),
                  Text(
                    titulo,
                    style: const TextStyle(fontSize: 18, color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
