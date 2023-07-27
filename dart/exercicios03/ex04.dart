import 'dart:io';

double media(List<double> valores) {
  double soma = 0;
  for (var valor in valores) {
    soma += valor;
  }
  return soma / valores.length;
}

main() {
  final List<double> medias = [];
  for (var i = 1; i < 4; i++) {
    print('Insira as notas do aluno $i (separadas por espaço):');
    // converte a entrada do usuário em uma lista de valores do tipo 'double'
    List<double> notas =
        stdin.readLineSync().toString().split(' ').map(double.parse).toList();

    final double mediaAluno = media(notas);
    medias.add(mediaAluno);
    print('Média do aluno $i: $mediaAluno');
  }
  final double mediaGeral = media(medias);
  print('Média geral da turma: $mediaGeral');
}
