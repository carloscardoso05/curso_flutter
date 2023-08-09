import 'package:flutter/material.dart';
import 'package:sistema_de_estoque/ExibirProduto.dart';
import 'package:sistema_de_estoque/models/Produto.dart';
import 'package:sistema_de_estoque/screens/CadastrarProduto.dart';
import 'package:sistema_de_estoque/screens/Estatisticas.dart';

class MeusProdutos extends StatefulWidget {
  const MeusProdutos({super.key, required this.produtos});
  final List<Produto> produtos;

  @override
  State<MeusProdutos> createState() => _MeusProdutosState();
}

class _MeusProdutosState extends State<MeusProdutos> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Meus Produtos'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => Estatisticas(
                            produtos: widget.produtos,
                            salvar: (Produto novoProduto, Produto antigoProduto) {
                              setState(() {
                                int index = widget.produtos.indexOf(antigoProduto);
                                widget.produtos[index] = novoProduto;
                              });
                            },
                          )));
            },
            icon: const Icon(Icons.info_outline),
          )
        ],
      ),
      body: Container(
        alignment: Alignment.topCenter,
        child: SizedBox(
          width: 600,
          child: ListView(
            children: widget.produtos.map((produto) {
              return ExibirProduto(
                produto: produto,
                salvar: (Produto novoProduto) {
                  setState(() {
                    int index = widget.produtos.indexOf(produto);
                    widget.produtos[index] = novoProduto;
                  });
                },
              );
            }).toList(),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          Produto? novoProduto = await Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => CadastrarProduto()),
          );
          if (novoProduto != null) {
            setState(() {
              widget.produtos.add(novoProduto);
            });
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
