void main() {
  const String nome = "Carlos Vitor";
  int idade = 17;
  bool ehNovato = true;
  double peso = 48.5;
  final List<double> notas = [10, 8, 5, 9];
  const Set<String> disciplinas = {"Matemática", "Física", "Química"};
  String endereco = "Rua Catorze";

  final String pesoBalanca = '48.62';
  double pesoAtual = double.parse(pesoBalanca);

  pesoAtual = pesoAtual.abs();

  pesoAtual = pesoAtual.round().toDouble();

  print('Peso: $pesoAtual kg');
}