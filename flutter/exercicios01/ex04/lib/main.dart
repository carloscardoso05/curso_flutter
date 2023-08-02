import 'package:flutter/material.dart';
import 'Categoria.dart';

void main() {
  runApp(const MainApp());
}

final Map<String, List<String>> dados = {
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
    ],
  };

  //valores de filtro
  static const int? categoriaFiltro = null;
  static final dadosEntries = dados.entries.toList();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: const Text('Minhas receitas'),
          ),
          body: Column(
            children: [
              for (int i = 0; i < dados.length; i++)
                if (categoriaFiltro == i + 1 || categoriaFiltro == null)
                  Container(
                    height: 300,
                    child: Categoria(
                      titulo: dadosEntries[i].key,
                      receitas: dadosEntries[i].value,
                    ),
                  ),
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
