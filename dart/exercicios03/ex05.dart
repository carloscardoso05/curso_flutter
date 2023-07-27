import 'dart:io';

main() {
  final descontar = (double valor) => valor * 0.85;

  double valor;
  print('Insira o valor do produto:');
  valor = double.parse(stdin.readLineSync().toString());
  valor = descontar(valor);
  print('O valor com um deconto de 15% fica R\$$valor');
}
