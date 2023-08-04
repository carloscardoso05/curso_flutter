import 'package:flutter/material.dart';
import 'ReceitaDetalhes.dart';

class Receita extends StatelessWidget {
  const Receita(
      {super.key,
      required this.titulo,
      required this.icone,
      required this.detalhes});
  final String titulo;
  final String detalhes;
  final IconData icone;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: Card(
          child: Column(
            children: [
              ListTile(
                leading: Icon(icone),
                title: Text(titulo),
              ),
              const Expanded(
                child: Icon(
                  Icons.image,
                  color: Colors.grey,
                  size: 50,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                    child: TextButton(
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStatePropertyAll(Colors.blue.shade50)),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return ReceitaDetalhes(
                                receita: titulo, detalhes: detalhes);
                            },
                          ),
                        );
                      },
                      child: const SizedBox(
                        height: 40,
                        child: Center(child: Text('Detalhes')),
                      ),
                    ),
                  ),
                  Expanded(
                    child: TextButton(
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStatePropertyAll(Colors.blue.shade50)),
                      onPressed: () {},
                      child: const SizedBox(
                        height: 40,
                        child: Center(child: Text('Adicionar')),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
