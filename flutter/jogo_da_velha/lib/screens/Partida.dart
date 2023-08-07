import 'package:flutter/material.dart';

class Partida extends StatefulWidget {
  Partida({super.key, required this.jogadores});
  final List<String> jogadores;

  int? alguemGanhou(List<List<int>> tabuleiro) {
    //linha
    for (var i = 0; i < 3; i++) {
      List<int> linha = tabuleiro[i];
      if (linha.every((element) => element == 1) ||
          linha.every((element) => element == 2)) {
        return linha.first;
      }
    }

    //coluna
    for (var i = 0; i < 3; i++) {
      List<int> coluna = [tabuleiro[0][i], tabuleiro[1][i], tabuleiro[2][i]];
      if (coluna.every((element) => element == 1) ||
          coluna.every((element) => element == 2)) {
        return coluna.first;
      }
    }

    //diagonal
    List<int> diagonal = [tabuleiro[0][0], tabuleiro[1][1], tabuleiro[2][2]];
    if (diagonal.every((valor) => valor == 1) ||
        diagonal.every((valor) => valor == 1)) {
      return diagonal.first;
    }

    //diagonal inversa
    List<int> diagonalInversa = [
      tabuleiro[0][2],
      tabuleiro[1][1],
      tabuleiro[2][0]
    ];
    if (diagonalInversa.every((valor) => valor == 1) ||
        diagonalInversa.every((valor) => valor == 1)) {
      return diagonalInversa.first;
    }

    if (tabuleiro.every((linha) => linha.every((valor) => valor != 0))) {
      return 0; //empate
    }

    return null; //ainda não acabou
  }

  @override
  State<Partida> createState() => _PartidaState();
}

class _PartidaState extends State<Partida> {
  int? vencedor;
  int jogadorVez = 1;
  List<List<int>> tabuleiro = [
    List.filled(3, 0),
    List.filled(3, 0),
    List.filled(3, 0),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Jogo da Velha'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ExibirJogador(
                  nome: widget.jogadores.first,
                  ehVez: jogadorVez == 1,
                  icone: Icons.close_rounded,
                ),
                ExibirJogador(
                  nome: widget.jogadores.last,
                  ehVez: jogadorVez == 2,
                  icone: Icons.circle_outlined,
                ),
              ],
            ),
            SizedBox(
              height: 400,
              width: 400,
              child: GridView.count(
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                crossAxisCount: 3,
                children: [
                  for (var i = 0; i < 3; i++)
                    for (var j = 0; j < 3; j++)
                      Casa(
                        valor: tabuleiro[i][j],
                        clicavel: widget.alguemGanhou(tabuleiro) == null,
                        selecionado: () {
                          setState(() {
                            tabuleiro[i][j] = jogadorVez;
                            vencedor = widget.alguemGanhou(tabuleiro);
                          });
                          if (vencedor == null) {
                            if (jogadorVez == 1) {
                              jogadorVez = 2;
                            } else {
                              jogadorVez = 1;
                            }
                          }
                        },
                      )
                ],
              ),
            ),
            if (widget.alguemGanhou(tabuleiro) != null)
              Column(
                children: [
                  Text(() {
                    switch (vencedor) {
                      case 0:
                        return 'O jogo terminou em empate';
                      default:
                        return '${widget.jogadores[jogadorVez - 1]} ganhou o jogo!';
                    }
                  }()),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        tabuleiro = [
                          List.filled(3, 0),
                          List.filled(3, 0),
                          List.filled(3, 0),
                        ];
                        jogadorVez = 1;
                      });
                    },
                    child: const Text('Iniciar novo jogo'),
                  )
                ],
              ),
          ],
        ),
      ),
    );
  }
}

class Casa extends StatelessWidget {
  Casa(
      {super.key,
      required this.selecionado,
      required this.valor,
      required this.clicavel});
  final bool clicavel;
  final int valor;
  final Function selecionado;
  final List<Widget> icones = [
    Container(),
    const Icon(Icons.close_rounded),
    const Icon(Icons.circle_outlined)
  ];

  @override
  Widget build(BuildContext context) {
    return Ink(
      decoration: BoxDecoration(color: Colors.grey.shade200),
      child: () {
        if (valor == 0 && clicavel) {
          return InkWell(
            onTap: () => selecionado(),
          );
        } else {
          return Container(
            child: icones[valor],
          );
        }
      }(),
    );
  }
}

class ExibirJogador extends StatelessWidget {
  const ExibirJogador(
      {super.key,
      required this.nome,
      required this.ehVez,
      required this.icone});
  final String nome;
  final bool ehVez;
  final IconData icone;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          nome,
          style: TextStyle(
            fontSize: 20,
            color: ehVez ? Colors.blue : Colors.black,
          ),
        ),
        Icon(
          icone,
          color: ehVez ? Colors.blue : Colors.black,
        ),
      ],
    );
  }
}
