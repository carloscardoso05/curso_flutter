import 'package:flutter/material.dart';
import 'package:teste_de_conhecimentos/screens/HomePage.dart';

class FimDeJogo extends StatelessWidget {
  const FimDeJogo({super.key, required this.acertos});
  final int acertos;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.topCenter,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const Expanded(
              child: Text(
                'Fim de Jogo',
                style: TextStyle(
                  fontSize: 50,
                  color: Colors.blue,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Expanded(
              child: Text(
                'Você acertou $acertos questões \n Parabéns!',
                style: const TextStyle(
                  fontSize: 25,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Flexible(
                child: FloatingActionButton.extended(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => const HomePage()));
              },
              label: const Text('Jogar novamente'),
              icon: const Icon(Icons.play_arrow_rounded),
            ))
          ],
        ),
      ),
    );
  }
}
