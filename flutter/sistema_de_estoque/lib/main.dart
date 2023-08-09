import 'package:flutter/material.dart';
import '/screens/MeusProdutos.dart';
import '/produtosDados.dart' show produtos;

main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sistema de Estoque',
      home: MeusProdutos(
        produtos: produtos
      )
    );
  }
}
