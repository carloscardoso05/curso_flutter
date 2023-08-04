import 'package:flutter/material.dart';
import 'CarrinhoDados.dart';

class Carrinho extends StatefulWidget {
  const Carrinho({super.key});

  @override
  State<Carrinho> createState() => _CarrinhoEstado();
}

class _CarrinhoEstado extends State<Carrinho> {
  final List<String> pratos = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Meu Carrinho'),
      ),
      body: Container(
        alignment: Alignment.topCenter,
        child: Column(
          children: [
            for (String prato in produtos)
            Text(prato)
          ],
        ),
      ),
    );
  }
}
