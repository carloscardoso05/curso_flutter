import 'dart:io';

main()async{
  List<int> tamanhoNomes = [];
  print('Digite os nomes separados por espaço:');
  final List<String> nomes = stdin.readLineSync().toString().split(' ');
  final nomesStream = Stream<List<String>>.value(nomes);
  await nomesStream.first.then((nomes) {
    tamanhoNomes = nomes.map((nome) => nome.length).toList();
  });

  print('Tamanhos dos nomes: $tamanhoNomes');
}