main() {
  const String nome = "Carlos Vitor";
  int idade = 17;
  bool ehNovato = true;
  double peso = 48.5;
  final List<double> notas = [10, 8, 5, 9];
  const Set<String> disciplinas = {"Matemática", "Física", "Química"};
  String endereco = "Rua Catorze";

  notas.add(10);
  notas.removeAt(2);
  final List<double> notas1Semestre = notas.sublist(0, 2);
  notas.remove(11);
  notas.sort();
  print('Notas: $notas');
}
