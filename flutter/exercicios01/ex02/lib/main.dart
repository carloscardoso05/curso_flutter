import 'package:flutter/material.dart';
import 'Categoria.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  static const List<String> sobremesas = [
    'Torta de Maçã',
    'Mousse de Chocolate',
    'Pudim de Leite Condensado',
  ];
  static const List<String> pratosPrincipais = [
    'Frango Assado com Batatas',
    'Espaguete à Bolonhesa',
    'Risoto de Cogumelos',
  ];
  static const List<String> aperitivos = [
    'Bolinhos de Queijo',
    'Bruschetta de Tomate e Manjericão',
    'Canapés de Salmão com Cream Cheese',
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: const Text('Minhas receitas'),
          ),
          body: Column(
            children: [
              Categoria(titulo: 'Sobremesas', receitas: sobremesas),
              Categoria(titulo: 'Pratos Principais', receitas: pratosPrincipais),
              Categoria(titulo: 'Aperitivos', receitas: aperitivos),
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
