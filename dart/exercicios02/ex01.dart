import 'dart:io';

main() {
  print('Digite o primeiro número:');
  final double numero1 = double.parse(stdin.readLineSync().toString());
  print('Digite o segundo número:');
  final double numero2 = double.parse(stdin.readLineSync().toString());

  print('$numero1 + $numero2 = ${numero1 + numero2}');
  print('$numero1 - $numero2 = ${numero1 - numero2}');
  print('$numero1 * $numero2 = ${numero1 * numero2}');
  print('$numero1 / $numero2 = ${numero1 / numero2}');
  print('$numero1 % $numero2 = ${numero1 % numero2}');
}
