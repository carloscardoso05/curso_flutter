main() {
  String redacao =
      "Minhas férias foram muito boas, não poderia ser mais melhor. Só queria que durassem mais.";

  if (redacao.contains('férias')) {
    print('A redação possui o termo "férias"');
  } else {
    print('A redação não possui o termo "férias"');
  }

  print('A redação possui ${" ".allMatches(redacao).length + 1} palavras');

  redacao = redacao.replaceAll("mais melhor", "melhor");
  print("Redação corrigida:");
  print(redacao);
}
