import 'Veiculo.dart';

class Moto extends Veiculo {
  double cilindradas;
  bool temPartidaEletrica;

  Moto(
      {required super.marca,
      required super.modelo,
      required super.anoFabricacao,
      required super.precoBase,
      required this.cilindradas,
      required this.temPartidaEletrica});

  // define o estado da moto (Leve, Normal ou Esportiva)
  String get estado {
    String estado = 'Leve';
    if (this.cilindradas > 500) {
      estado = 'Esportiva';
    }
    if (125 <= this.cilindradas && this.cilindradas <= 500) {
      estado = 'Normal';
    }
    return estado;
  }

  // calcula o preço adicional
  double get precoAdicional {
    double adicional = this.cilindradas * 0.05 + this.precoBase;
    if (this.temPartidaEletrica) {
      adicional += 500;
    }
    return adicional;
  }
  
  // calcula o preço total
  double get precoTotal {
    return this.precoBase + this.precoAdicional;
  }


  @override
  String toString() {
    return '''
---------------Moto---------------
    Marca: $marca
    Modelo: $modelo
    Ano de fabricação: $anoFabricacao
    Número de cilindradas: $cilindradas
    Tem partida elétrica: $temPartidaEletrica
    Estado: $estado
    Preço base: $precoBase
    Preço adicional: $precoAdicional
    Preço total: $precoTotal
----------------------------------
''';
  }
}
