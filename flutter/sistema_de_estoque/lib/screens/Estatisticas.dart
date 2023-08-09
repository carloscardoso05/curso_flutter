import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:sistema_de_estoque/ExibirProduto.dart';
import 'package:sistema_de_estoque/models/Produto.dart';
// import '../produtosDados.dart' show produtos;

class Estatisticas extends StatefulWidget {
  Estatisticas({super.key, required this.produtos, required this.salvar});
  final formatacao = NumberFormat.simpleCurrency(locale: 'pt_BR');
  final List<Produto> produtos;
  final Function salvar;

  @override
  State<Estatisticas> createState() => _EstatisticasState();
}

class _EstatisticasState extends State<Estatisticas> {
  int get quantidadeTotal {
    int quantidadeTotal = 0;
    for (Produto produto in widget.produtos) {
      quantidadeTotal += produto.quantidade;
    }
    return quantidadeTotal;
  }

  double get valorTotal {
    double valorTotal = 0;
    for (Produto produto in widget.produtos) {
      valorTotal += produto.preco;
    }
    return valorTotal;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Estatísticas')),
      body: Container(
        alignment: Alignment.topCenter,
        child: SizedBox(
          width: 600,
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: ListTile(
                  leading: const Icon(Icons.poll_rounded),
                  title: const Text('Quantidade Total'),
                  trailing: Text(quantidadeTotal.toString()),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: ListTile(
                  leading: const Icon(Icons.monetization_on),
                  title: const Text('Valor Total'),
                  trailing: Text(widget.formatacao.format(valorTotal)),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 10),
                child: ListTile(
                  leading: Icon(Icons.remove_shopping_cart),
                  title: Text('Itens com Estoque Baixo'),
                  trailing: Icon(Icons.arrow_downward_rounded),
                ),
              ),
              ...widget.produtos.map((produto) {
                if (produto.quantidade <= 5) {
                  return ExibirProduto(
                    produto: produto,
                    salvar: (Produto novoProduto) {
                      setState(() {
                        widget.salvar(novoProduto, produto);
                      });
                    },
                  );
                } else {
                  return Container();
                }
              }),
            ],
          ),
        ),
      ),
    );
  }
}
