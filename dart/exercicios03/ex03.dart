import 'dart:io';
main() {
  print('Preço máximo:');
  final int preco_maximo = int.parse(stdin.readLineSync().toString());
  final List<int> precos =
      List.generate((preco_maximo / 2).floor()+1, (index) => index * 2).toList();
  print('Preços:');
  print(precos);
}