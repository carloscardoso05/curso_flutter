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

//valores de filtro
const int? categoriaFiltro = null;
const String? textoPesquisa = 'De';

//funções de filtro
Map<String, List<String>> filtrarCategorias(
    int? categoriaFiltro, Map<String, List<String>> dados) {
  switch (categoriaFiltro) {
    case 1:
      return {'Sobremesas': dados['Sobremesas'] as List<String>};
    case 2:
      return {'Pratos Principais': dados['Pratos Principais'] as List<String>};
    case 3:
      return {'Aperitivos': dados['Aperitivos'] as List<String>};
    default:
      return dados;
  }
}

Map<String, List<String>> filtrarTextos(
    String? textoPesquisa, Map<String, List<String>> dados) {
  if (textoPesquisa == null && textoPesquisa!.isNotEmpty) {
    dados.forEach((categoria, receitas) {
      receitas.removeWhere((receita) =>
          !receita.toLowerCase().contains(textoPesquisa.toLowerCase()));
    });
  }
  return dados;
}

// filtra os dados por categoria e por texto
final Map<String, List<String>> categoriasFiltradas =
    filtrarCategorias(categoriaFiltro, dados);
final Map<String, List<String>> receitasFiltradas =
    filtrarTextos(textoPesquisa, categoriasFiltradas);

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Minhas receitas'),
        ),
        body: Container(
          color: Colors.red,
          alignment: Alignment.topCenter,
          height: MediaQuery.of(context).size.height * 0.70,
          width: MediaQuery.of(context).size.width * 0.75,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              for (String categoria in receitasFiltradas.keys)
                Flexible(
                  child: Categoria(
                    titulo: categoria,
                    receitas: dados[categoria] as List<String>,
                  ),
                )
            ],
          ),
        ),
        floatingActionButton: Ink(
          decoration: ShapeDecoration(
              shape: CircleBorder(),
              color: Theme.of(context).colorScheme.primary),
          child: IconButton(
            color: Theme.of(context).colorScheme.inversePrimary,
            icon: Icon(Icons.add),
            splashRadius: 20,
            onPressed: () {},
          ),
        ),
      ),
    );
  }
}
//