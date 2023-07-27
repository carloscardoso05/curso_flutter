import 'dart:io';

main() {
  print('Insira um número:');
  final int num = int.parse(stdin.readLineSync().toString());
  final String resposta1;
  final String resposta2;
  final String resposta3;
  if (10 < num && num < 20) {
    resposta1 = 'Sim';
  } else {
    resposta1 = 'Não';
  }
  if (num == 0 || num == 50) {
    resposta2 = 'Sim';
  } else {
    resposta2 = 'Não';
  }
  if (num != 100 || num == 200) {
    resposta3 = 'Sim';
  } else {
    resposta3 = 'Não';
  }
  print('O número é maior que 10 e menor que 20? R: $resposta1');
  print('O número é igual a 0 ou igual a 50? R: $resposta2');
  print('O número é diferente de 100 ou igual a 200? R: $resposta3');
}
