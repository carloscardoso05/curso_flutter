import 'package:flutter/material.dart';

class Contador extends StatefulWidget {
  const Contador({super.key, required this.valorInicial});
  final int valorInicial;

  @override
  State<Contador> createState() => _EstadoContador();
}

class _EstadoContador extends State<Contador> {
  late int valorInicial;
  late int valor;

  @override
  void initState() {
    super.initState();
    valorInicial = widget.valorInicial;
    valor = widget.valorInicial;
  }

  void setValorInicial(value) {
    setState(() {
      try {
        valorInicial = int.parse(value);
      } catch (error) {
        valorInicial = 0;
      }
    });
  }

  void adicionar() {
    setState(() {
      valor++;
    });
  }

  void resetar() {
    setState(() {
      valor = valorInicial;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      child: Column(
        children: [
          TextFormField(
            initialValue: valorInicial.toString(),
            decoration: const InputDecoration(
              labelText: 'Valor Inicial',
              hintText: 'O valor inicial do contador',
              border: OutlineInputBorder(),
            ),
            onChanged: (value) => setValorInicial(value),
          ),
          Text('Valor: $valor'),
          TextButton(
            onPressed: adicionar,
            child: const Text('Adicionar'),
          ),
          TextButton(
            onPressed: resetar,
            child: const Text('Resetar'),
          ),
        ],
      ),
    );
  }
}
