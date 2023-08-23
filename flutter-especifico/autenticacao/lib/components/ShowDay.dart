import 'package:flutter/material.dart';

class ShowDay extends StatelessWidget {
  ShowDay({super.key});
  static const Map<int, String> weekDays = {
    1: 'Segunda-Feira',
    2: 'Terça-Feira',
    3: 'Quarta-Feira',
    4: 'Quinta-Feira',
    5: 'Sexta-Feira',
    6: 'Sábado',
    7: 'Domingo',
  };
  final int day = DateTime.now().day;
  final int weekDay = DateTime.now().weekday;
  @override
  Widget build(BuildContext context) {
    return Text(
      'Dia $day - ${weekDays[weekDay]}',
      style: const TextStyle(fontSize: 30),
    );
  }
}
