import 'package:flutter/material.dart';
import 'Receita.dart';

class Secao extends StatelessWidget {
  const Secao({super.key, required this.titulo, required this.receitas});
  final String titulo;
  final List<List<String>> receitas;

  static final Map<String, IconData> icones = {
    'Sobremesas': Icons.icecream_outlined,
    'Pratos Principais': Icons.restaurant,
    'Aperitivos': Icons.kebab_dining_outlined,
    'Massas': Icons.dinner_dining_outlined,
    'Bebidas': Icons.local_bar_outlined,
  };

  @override
  Widget build(BuildContext context) {
    if (receitas.isNotEmpty) {
      return Column(
      children: [
        Expanded(
          child: Center(
            child: Text(
              titulo,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              for (final List<String> receita in receitas)
                SizedBox(
                    width: 250,
                    height: 200,
                    child: Receita(
                      titulo: receita[0],
                      detalhes: receita[1],
                      icone: () {
                        if (icones.keys.contains(titulo)) {
                          return icones[titulo] as IconData;
                        }
                        return Icons.restaurant_menu_outlined;
                      }(),
                    ))
            ],
          ),
        )
      ],
    );
    }
    else {
      return Container();
    }
  }
}
