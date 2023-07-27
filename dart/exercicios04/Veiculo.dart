class Veiculo {
  String marca;
  String modelo;
  int anoFabricacao;
  double precoBase;

  Veiculo({
    required this.marca,
    required this.modelo,
    required this.anoFabricacao,
    required this.precoBase
  });

  @override
  String toString() {
    return '''
----------------------------------
    Marca: $marca
    Modelo: $modelo
    Ano de fabricação: $anoFabricacao
    Preço base: $precoBase
----------------------------------''';
  }
}