void main() {
  const String nome = "Carlos Vitor";
  int idade = 17;
  bool ehNovato = true;
  double peso = 48.5;
  final List<double> notas = [10, 8, 5, 9];
  const Set<String> disciplinas = {"Matemática", "Física", "Química"};
  String endereco = "Rua Catorze";

  final Map<String, double> pesos = {};

  pesos['Carol'] = 58.2;

  pesos[nome] = peso;

  pesos['Daniel'] = 65.3;
  pesos['Roberto'] = 70.8;

  final double? pesoNovo = pesos['Roberto'];

  pesos.remove('Carol');

  print("Estou no mapa: ${pesos.containsKey('Carlos')}");

  print('Pesos: $pesos');
}