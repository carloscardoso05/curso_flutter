import 'dart:io';

main() {
  print('Insira sua idade:');
  final int idade = int.parse(stdin.readLineSync().toString());
  if (idade >= 18) {
    print('Você é maior de idade');
  } else {
    print('Você é menor de idade');
  }
}
