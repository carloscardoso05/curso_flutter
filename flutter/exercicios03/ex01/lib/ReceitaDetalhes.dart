import 'package:flutter/material.dart';
import 'main.dart' show MainApp;
import 'CarrinhoDados.dart';

class ReceitaDetalhes extends StatelessWidget {
  const ReceitaDetalhes(
      {super.key, required this.titulo, required this.detalhes});
  final String titulo;
  final String detalhes;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: const Text('Deseja voltar para a Página Inicial?'),
                  actions: [
                    ElevatedButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Cancelar'),
                    ),
                    ElevatedButton(
                      onPressed: () => Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const MainApp(),
                        ),
                      ),
                      child: const Text('Confirmar'),
                    )
                  ],
                );
              },
            );
          },
        ),
        title: const Text('Detalhes'),
      ),
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.75,
          constraints: const BoxConstraints(maxWidth: 700),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                child: Text(
                  titulo,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Text(
                detalhes,
                style: const TextStyle(
                  fontSize: 18,
                ),
                textAlign: TextAlign.justify,
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        onPressed: () {
          produtos.add(titulo);
          Navigator.pop(context);
        },
        child: const Icon(Icons.add_shopping_cart_outlined, fill: 0, color: Colors.white,),
      ),
    );
  }
}
