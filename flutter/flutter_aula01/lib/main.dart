import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Olá',
                style: TextStyle(
                  color: Colors.indigo.shade900,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Icon(Icons.back_hand, size: 40, color: Colors.amber.shade700),
            ],
          ),
        ),
        body: const Center(
          child: Text('Hello World!'),
        ),
      ),
    );
  }
}
