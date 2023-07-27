main() {
  const String nome = "Carlos Vitor";
  int idade = 17;
  bool ehNovato = true;
  double peso = 48.5;
  final List<double> notas = [10, 8, 5, 9];
  const Set<String> disciplinas = {"Matemática", "Física", "Química"};
  String endereco = "Rua Catorze";

  print('''
==*==*== DADOS DO ALUNO ==*==*==
Nome: $nome
Idade: $idade
É novato: $ehNovato
Peso: $peso
Notas: $notas
Disciplinas: $disciplinas
Endereço: $endereco
''');
}
