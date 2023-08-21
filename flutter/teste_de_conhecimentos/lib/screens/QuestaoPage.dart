import 'package:flutter/material.dart';
import 'package:teste_de_conhecimentos/components/Timer.dart';
import 'package:teste_de_conhecimentos/models/Questao.dart';
import '../components/Alternativa.dart';

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
              const Flexible(
                flex: 1,
                child: Timer(duration: Duration(seconds: 20)),
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
                Alternativa(
                  indexQuestao: indexQuestao,
                  questoes: questoes,
                  resposta: resposta,
                  acertos: acertos,
                )
            ],
          ),
        ),
      ),
    );
  }
}
