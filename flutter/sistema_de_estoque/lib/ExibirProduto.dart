import 'package:flutter/material.dart';
import 'package:sistema_de_estoque/models/Produto.dart';
import 'package:sistema_de_estoque/screens/CadastrarProduto.dart';

class ExibirProduto extends StatelessWidget {
  const ExibirProduto({super.key, required this.produto, required this.salvar});
  final Produto produto;
  final Function salvar;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
      child: Row(
        children: [
          Expanded(
            child: ListTile(
              leading: const Icon(Icons.shopping_bag),
              title: Text(
                produto.nome,
                style: const TextStyle(fontWeight: FontWeight.w500),
              ),
              subtitle: Text('${produto.descricao} (R\$ ${produto.preco})'),
              trailing: Text('x${produto.quantidade}'),
            ),
          ),
          IconButton(
              onPressed: () async {
                final Produto novoProduto = await Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => CadastrarProduto.inicial(
                              produto: produto,
                            )));
                salvar(novoProduto);
              },
              icon: Icon(
                Icons.edit,
                color: Colors.grey.shade500,
              ))
        ],
      ),
    );
  }
}
