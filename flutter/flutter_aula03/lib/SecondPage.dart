import 'package:flutter/material.dart';
import 'main.dart' show HomePage;

class SecondPage extends StatelessWidget {
  const SecondPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tela Secundária'),
      ),
      body: const Center(
        child: Text('Tela 2'),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.arrow_back),
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text('Deseja voltar?'),
              actions: [
                ElevatedButton(
                    onPressed: () => Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HomePage(),
                        )),
                    child: Text('Voltar'))
              ],
            ),
          );
        },
      ),
    );
  }
}
