import 'package:flutter/material.dart';
import 'Categoria.dart';
import 'receitasDados.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  static const Map<String, List<List<String>>> dados = receitasDados;

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
                        labelText: 'Buscar prato',
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
      ),
    );
  }
}
