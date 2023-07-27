import 'dart:io';

main() {
  print('Insira um número correspondente a um dia da semana:');
  final int dia = int.parse(stdin.readLineSync().toString());
  final String diaDaSemana;
  switch (dia) {
    case 1:
      diaDaSemana = 'Segunda-Feira';
      break;
    case 2:
      diaDaSemana = 'Terça-Feira';
      break;
    case 3:
      diaDaSemana = 'Quarta-Feira';
      break;
    case 4:
      diaDaSemana = 'Quinta-Feira';
      break;
    case 5:
      diaDaSemana = 'Sexta-Feira';
      break;
    case 6:
      diaDaSemana = 'Sábado';
      break;
    case 7:
      diaDaSemana = 'Domingo';
      break;
    default:
      diaDaSemana = 'Segunda-Feira';
      break;
  }

  print('Hoje é $diaDaSemana');
}
