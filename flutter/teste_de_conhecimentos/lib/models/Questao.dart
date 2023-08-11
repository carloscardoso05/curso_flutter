class Questao {
  Questao({
    required this.pergunta,
    required this.respostas,
    required this.respostaCerta,
  });
  String pergunta;
  int respostaCerta;
  List<String> respostas;
}
