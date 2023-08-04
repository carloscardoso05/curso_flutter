import 'package:flutter/material.dart';
import 'Secao.dart';
import 'receitasDados.dart';
import 'Carrinho.dart';

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
      theme: ThemeData(
        brightness: Brightness.dark,
      ),
      home: Builder(builder: (context) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Minhas receitas'),
            actions: [
              IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => Carrinho(),
                    ),
                  );
                },
                icon: const Icon(Icons.shopping_cart_outlined),
              ),
            ],
          ),
          body: SingleChildScrollView(
            child: Container(
              alignment: Alignment.topCenter,
              child: SizedBox(
                width: 800,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(30, 30, 30, 0),
                      child: TextField(
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.search),
                          labelText: 'Buscar prato',
                          labelStyle: TextStyle(fontSize: 20),
                          hintText: 'Digite o nome da receita para buscá-la',
                          border: OutlineInputBorder(),
                        ),
                        onChanged: (text) {
                          setState(() {
                            textoPesquisa = text;
                          });
                        },
                      ),
                    ),
                    for (int i = 0; i < MainApp.dados.length; i++)
                      if (MainApp.categoriaFiltro == i + 1 ||
                          MainApp.categoriaFiltro == null)
                        SizedBox(
                          height: 300,
                          child: Secao(
                            titulo: MainApp.dadosEntries[i].key,
                            receitas: MainApp.dadosEntries[i].value
                                .where((receita) =>
                                    receita[0]
                                        .toString()
                                        .toLowerCase()
                                        .contains(
                                            textoPesquisa.toLowerCase()) ||
                                    textoPesquisa.isEmpty)
                                .toList(),
                          ),
                        ),
                  ],
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
