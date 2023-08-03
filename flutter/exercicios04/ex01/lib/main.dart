import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    home: Tela(),
  ));
}

class Tela extends StatefulWidget {
  const Tela({super.key});

  @override
  State<Tela> createState() => _EstadoTela();
}

class _EstadoTela extends State<Tela> {
  int? valor;

  void setValor(int? novoValor) {
    setState(() {
      valor = novoValor;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          if(valor == null)
          const Text('Nenhum valor selecionado', style: TextStyle(fontSize: 20)),
          if(valor != null)
          Text('Opção $valor selecionada', style: const TextStyle(fontSize: 20)),
          RadioListTile(
            title: const Text('Opção 1'),
            value: 1,
            groupValue: valor,
            onChanged: (novoValor) => setValor(novoValor),
          ),
          RadioListTile(
            title: const Text('Opção 2'),
            value: 2,
            groupValue: valor,
            onChanged: (novoValor) => setValor(novoValor),
          ),
          RadioListTile(
            title: const Text('Opção 3'),
            value: 3,
            groupValue: valor,
            onChanged: (novoValor) => setValor(novoValor),
          ),
        ],
      ),
    );
  }
}
