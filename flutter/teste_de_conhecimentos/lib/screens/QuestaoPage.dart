import 'package:flutter/material.dart';
import 'package:teste_de_conhecimentos/models/Questao.dart';
import 'package:teste_de_conhecimentos/screens/FimDeJogo.dart';

class QuestaoPage extends StatelessWidget {
  const QuestaoPage({
    super.key,
    required this.questoes,
    required this.indexQuestao,
    required this.acertos,
  });
  final List<Questao> questoes;
  final int indexQuestao;
  final int acertos;
  Questao get questao => questoes[indexQuestao];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pergunta número ${indexQuestao + 1}'),
        centerTitle: true,
      ),
      body: Container(
        alignment: Alignment.topCenter,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: Column(
            children: [
              Flexible(
                flex: 1,
                child: Container(),
              ),
              Flexible(
                flex: 2,
                child: Container(
                  margin: const EdgeInsets.all(10),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    child: Text(
                      questao.pergunta,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
              ),
              for ((int, String) resposta in questao.respostas.indexed.toList())
                Flexible(
                  flex: 1,
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: Card(
                      child: InkWell(
                        onTap: () {
                          if (indexQuestao + 1 < questoes.length) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) {
                                  return QuestaoPage(
                                    questoes: questoes,
                                    indexQuestao: indexQuestao + 1,
                                    acertos:
                                        questao.respostaCerta == resposta.$1
                                            ? acertos + 1
                                            : acertos,
                                  );
                                },
                              ),
                            );
                          } else {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => FimDeJogo(
                                    acertos:
                                        questao.respostaCerta == resposta.$1
                                            ? acertos + 1
                                            : acertos),
                              ),
                            );
                          }
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 5),
                          child: ListTile(
                            leading: AlternativaLetra(
                                numeroAlternativa: resposta.$1),
                            title: Text(resposta.$2),
                          ),
                        ),
                      ),
                    ),
                  ),
                )
            ],
          ),
        ),
      ),
    );
  }
}

class AlternativaLetra extends StatelessWidget {
  const AlternativaLetra({super.key, required this.numeroAlternativa});
  final int numeroAlternativa;
  static const List<String> alternativas = ['A', 'B', 'C', 'D', 'E'];
  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: Container(
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.blue,
        ),
        alignment: Alignment.center,
        child: Text(
          alternativas[numeroAlternativa],
          style: const TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
        ),
      ),
    );
  }
}
