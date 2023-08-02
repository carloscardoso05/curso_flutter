import 'package:flutter/material.dart';
import 'Categoria.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

static final Map<String, List<String>> dados = {
  'Sobremesas': [
    'Torta de Maçã',
    'Mousse de Chocolate',
    'Pudim de Leite Condensado',
  ],
  'Pratos Principais': [
    'Frango Assado com Batatas',
    'Espaguete à Bolonhesa',
    'Risoto de Cogumelos',
  ],
  'Aperitivos': [
    'Bolinhos de Queijo',
    'Bruschetta de Tomate e Manjericão',
    'Canapés de Salmão com Cream Cheese',
  ]
};

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: const Text('Minhas receitas'),
          ),
          body: Column(
            children: [
              for (final categoria in dados.keys)
                Categoria(
                    titulo: categoria,
                    receitas: dados[categoria] as List<String>)
            ],
          ),
          floatingActionButton: CircleAvatar(
            backgroundColor: Colors.blue,
            radius: 35,
            child: IconButton(
              icon: const Icon(Icons.add),
              onPressed: () {},
            ),
          )),
    );
  }
}
