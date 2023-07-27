class Veiculo {
  String marca;
  String modelo;
  int anoFabricacao;

  Veiculo({
    required this.marca,
    required this.modelo,
    required this.anoFabricacao,
  });

  Veiculo.fiat({required this.modelo, required this.anoFabricacao}): marca = 'fiat';

  @override
  String toString() {
    return '''
----------------------------------
    Marca: $marca
    Modelo: $modelo
    Ano de fabricação: $anoFabricacao
----------------------------------''';
  }
}

main() {
  Veiculo veiculo = Veiculo(marca: 'Fiat', modelo: 'Uno', anoFabricacao: 2005);
  print(veiculo);
  Veiculo veiculo2 = Veiculo.fiat(modelo: 'Uno2', anoFabricacao: 2000);
  print(veiculo2);
}