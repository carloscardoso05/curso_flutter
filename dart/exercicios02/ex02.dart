import 'dart:io';

main() {
  print('Insira um número:');
  final int num = int.parse(stdin.readLineSync().toString());
  if (num % 2 == 0) {
    print('O número $num é par');
  } else {
    print('O número $num é ímpar');
  }
}
