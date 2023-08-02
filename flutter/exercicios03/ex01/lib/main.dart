import 'package:flutter/material.dart';
import 'Categoria.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  static final Map<String, List<List<String>>> dados = {
    'Sobremesas': [
      ['Torta de Maçã', 'Detalhes sobre a receita...'],
      ['Mousse de Chocolate', 'Detalhes sobre a receita...'],
      ['Pudim de Leite Condensado', 'Detalhes sobre a receita...'],
    ],
    'Pratos Principais': [
      ['Frango Assado com Batatas', 'Detalhes sobre a receita...'],
      ['Espaguete à Bolonhesa', 'Detalhes sobre a receita...'],
      ['Risoto de Cogumelos', 'Detalhes sobre a receita...'],
    ],
    'Aperitivos': [
      ['Bolinhos de Queijo', 'Detalhes sobre a receita...'],
      ['Bruschetta de Tomate e Manjericão', 'Detalhes sobre a receita...'],
      ['Canapés de Salmão com Cream Cheese', 'Detalhes sobre a receita...'],
    ],
    'Massas': [
      ['Macarronada de Camarão', 'Detalhes sobre a receita...'],
      ['Spaghetti com Almôndegas', 'Detalhes sobre a receita...'],
      ['Lasanha de Frango', 'Detalhes sobre a receita...'],
      ['Risotto de Camarão', 'Detalhes sobre a receita...'],
    ],
    'Bebidas': [
      ['Refrigerante', 'Detalhes sobre a receita...'],
      ['Água Mineral', 'Detalhes sobre a receita...'],
      ['Vinho', 'Detalhes sobre a receita...'],
      ['Suco', 'Detalhes sobre a receita...'],
    ]
  };

  //valores de filtro
  static const int? categoriaFiltro = null;
  static final dadosEntries = dados.entries.toList();

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  String textoPesquisa = '';
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Minhas receitas'),
        ),
        body: Container(
          alignment: Alignment.topCenter,
          child: SingleChildScrollView(
            child: Container(
              constraints: const BoxConstraints(
                maxWidth: 800,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  TextField(
                    decoration: const InputDecoration(
                        labelText: 'Nome da receita',
                        hintText: 'Digite o nome da receita para buscá-la'),
                    onChanged: (text) {
                      setState(() {
                        textoPesquisa = text;
                      });
                    },
                  ),
                  for (int i = 0; i < MainApp.dados.length; i++)
                    if (MainApp.categoriaFiltro == i + 1 ||
                        MainApp.categoriaFiltro == null)
                      SizedBox(
                        height: 300,
                        child: Categoria(
                          titulo: MainApp.dadosEntries[i].key,
                          receitas: MainApp.dadosEntries[i].value
                              .where((receita) =>
                                  receita[0].contains(textoPesquisa) ||
                                  textoPesquisa.isEmpty)
                              .toList(),
                        ),
                      ),
                ],
              ),
            ),
          ),
        ),
        floatingActionButton: Ink(
          decoration: ShapeDecoration(
              shape: const CircleBorder(),
              color: Theme.of(context).colorScheme.primary),
          child: IconButton(
            color: Theme.of(context).colorScheme.inversePrimary,
            icon: const Icon(Icons.add),
            splashRadius: 20,
            onPressed: () {},
          ),
        ),
      ),
    );
  }
}
