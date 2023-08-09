import 'package:flutter/material.dart';
import 'package:sistema_de_estoque/models/Produto.dart';

class CadastrarProduto extends StatefulWidget {
  CadastrarProduto({super.key})
      : produto = Produto(nome: '', descricao: '', quantidade: 0, preco: 0);
  CadastrarProduto.inicial({super.key, required this.produto});
  Produto produto;
  @override
  State<CadastrarProduto> createState() => _CadastrarProdutoState();
}

class _CadastrarProdutoState extends State<CadastrarProduto> {
  late Produto produto;
  @override
  void initState() {
    super.initState();
    produto = widget.produto;
  }

  String? nomeErro;
  String? precoErro;
  bool get ehValido =>
      nomeErro == null &&
      precoErro == null &&
      produto.nome.isNotEmpty &&
      produto.preco != 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastrar Produto'),
      ),
      body: Container(
        alignment: Alignment.topCenter,
        child: SizedBox(
          width: 600,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(10),
                child: TextFormField(
                  initialValue: produto.nome,
                  decoration: InputDecoration(
                      hintText: 'Nome do Produto',
                      labelText: 'Nome',
                      errorText: nomeErro,
                      border: const OutlineInputBorder()),
                  onChanged: (novoNome) => setState(() {
                    produto.nome = novoNome;
                    if (novoNome.isEmpty) {
                      nomeErro = 'O nome não pode ser vazio';
                    } else {
                      nomeErro = null;
                    }
                  }),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: TextFormField(
                  initialValue: produto.descricao,
                  decoration: const InputDecoration(
                    hintText: 'Descrição do Produto',
                    labelText: 'Descrição',
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (novaDescricao) => setState(() {
                    produto.descricao = novaDescricao;
                  }),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: TextFormField(
                  initialValue:
                      produto.preco == 0 ? '' : produto.preco.toString(),
                  decoration: InputDecoration(
                    hintText: 'Preço do Produto',
                    labelText: 'Preço',
                    errorText: precoErro,
                    border: const OutlineInputBorder(),
                  ),
                  onChanged: (novoPreco) {
                    setState(
                      () {
                        double? novoPrecoDouble = double.tryParse(novoPreco);
                        if (novoPreco.isEmpty) {
                          precoErro = 'O preço não pode ser vazio';
                        } else if (novoPrecoDouble == null ||
                            novoPrecoDouble <= 0) {
                          precoErro = 'Preço inválido';
                        } else {
                          precoErro = null;
                          produto.preco = novoPrecoDouble;
                        }
                      },
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(width: 1, color: Colors.grey),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Container(
                    height: 50,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      // mainAxisSize: MainAxisSize.min,
                      children: [
                        Expanded(
                          flex: 1,
                          child: InkWell(
                            onTap: () {
                              if (produto.quantidade > 0) {
                                setState(
                                  () {
                                    produto.quantidade--;
                                  },
                                );
                              }
                            },
                            child: const SizedBox(
                              height: double.infinity,
                              child: Icon(
                                Icons.remove_circle_outline,
                                color: Colors.blueAccent,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Text(
                            produto.quantidade.toString(),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: InkWell(
                            onTap: () {
                              setState(
                                () {
                                  produto.quantidade++;
                                },
                              );
                            },
                            child: const SizedBox(
                              height: double.infinity,
                              child: Icon(
                                Icons.add_circle_outline,
                                color: Colors.blueAccent,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              ElevatedButton(
                statesController: MaterialStatesController(),
                onPressed: ehValido
                    ? () {
                        Navigator.pop(context, produto);
                      }
                    : () {},
                child: const Padding(
                  padding: EdgeInsets.all(10),
                  child: Text('Adicionar'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
