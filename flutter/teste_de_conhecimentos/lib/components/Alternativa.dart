import 'package:flutter/material.dart';
import '../models/Questao.dart';
import 'AlternativaLetra.dart';
import '../screens/FimDeJogo.dart';
import '../screens/QuestaoPage.dart';

class Alternativa extends StatelessWidget {
  const Alternativa({
    super.key,
    required this.indexQuestao,
    required this.questoes,
    required this.resposta,
    required this.acertos,
  });
  final int indexQuestao;
  final List<Questao> questoes;
  final (int, String) resposta;
  final int acertos;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      flex: 1,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
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
                            questoes[indexQuestao].respostaCerta == resposta.$1
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
                            questoes[indexQuestao].respostaCerta == resposta.$1
                                ? acertos + 1
                                : acertos),
                  ),
                );
              }
            },
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 5),
              child: ListTile(
                leading: AlternativaLetra(numeroAlternativa: resposta.$1),
                title: Text(resposta.$2),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
