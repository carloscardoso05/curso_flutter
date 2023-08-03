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
        body: Center(
          child: Container(
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height * 0.40,
              maxWidth: MediaQuery.of(context).size.width * 0.60,
            ),
            alignment: Alignment.center,
            margin: const EdgeInsets.only(bottom: 150),
            decoration: BoxDecoration(
              color: Colors.greenAccent.shade400,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(50),
                bottomRight: Radius.circular(50),
              ),
              border: Border.all(
                color: Colors.amber,
                style: BorderStyle.solid,
                width: 10,
              )
            ),
          ),
        ),
      ),
    );
  }
}
