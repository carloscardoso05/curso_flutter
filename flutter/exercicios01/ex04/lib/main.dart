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

  final int? categoriaFiltro = null;

  Map<String, List<String>> filtrarCategorias(
      int? categoriaFiltro, Map<String, List<String>> dados) {
    switch (categoriaFiltro) {
      case 1:
        return {'Sobremesas': dados['Sobremesas'] as List<String>};
      case 2:
        return {
          'Pratos Principais': dados['Pratos Principais'] as List<String>};
      case 3:
        return {'Aperitivos': dados['Aperitivos'] as List<String>};
      default:
        return dados;
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: const Text('Minhas receitas'),
          ),
          body: Column(
            children: [
              for (final categoria
                  in filtrarCategorias(categoriaFiltro, dados).keys)
                Categoria(
                  titulo: categoria,
                  receitas: dados[categoria] as List<String>,
                )
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
