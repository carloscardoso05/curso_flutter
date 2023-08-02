import 'package:flutter/material.dart';
import 'ReceitaDetalhes.dart';
class Receita extends StatelessWidget {
  const Receita({super.key, required this.titulo, required this.icone, required this.detalhes});
  final String titulo;
  final String detalhes;
  final IconData icone;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => ReceitaDetalhes(receita: titulo, detalhes: detalhes),)),
      child: Card(
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
                titulo,
                style: const TextStyle(fontSize: 18),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
