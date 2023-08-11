import 'package:flutter/material.dart';
import 'package:teste_de_conhecimentos/perguntasDados.dart';
import 'package:teste_de_conhecimentos/screens/QuestaoPage.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int acertos = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.topCenter,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              'Jogo de Perguntas',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 50,
                color: Colors.grey.shade600,
              ),
            ),
            FloatingActionButton.extended(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => QuestaoPage(
                      acertos: 0,
                      questoes: questoes,
                      indexQuestao: 0,
                    ),
                  ),
                );
              },
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5)),
              label: const Text('Jogar'),
              icon: const Icon(Icons.play_arrow_rounded),
            )
          ],
        ),
      ),
    );
  }
}
