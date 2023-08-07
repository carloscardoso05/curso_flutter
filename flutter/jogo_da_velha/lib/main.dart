import 'package:flutter/material.dart';
import 'screens/Partida.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Jogo da Velha',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<String> jogadores = ['Jogador 1', 'Jogador 2'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Jogo da Velha'),
        centerTitle: true,
      ),
      body: Center(
        child: Container(
          width: 400,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                child: NomeInput(
                  nomeInicial: 'Jogador 1',
                  onChanged: (novoNome) {
                    setState(() {
                      jogadores.first = novoNome;
                    });
                  },
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                child: NomeInput(
                  nomeInicial: 'Jogador 2',
                  onChanged: (novoNome) {
                    setState(() {
                      jogadores.last = novoNome;
                    });
                  },
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                child: FloatingActionButton.extended(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => Partida(
                                  jogadores: jogadores,
                                )));
                  },
                  label: const Text('Iniciar jogo'),
                  icon: const Icon(Icons.play_arrow),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class NomeInput extends StatelessWidget {
  const NomeInput(
      {super.key, required this.nomeInicial, required this.onChanged});
  final String nomeInicial;
  final Function onChanged;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: nomeInicial,
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        hintText: 'Nome do $nomeInicial',
        label: Text('Insira o nome do $nomeInicial'),
        prefixIcon: const Icon(Icons.person),
      ),
      onChanged: (novoNome) => onChanged(novoNome),
    );
  }
}
