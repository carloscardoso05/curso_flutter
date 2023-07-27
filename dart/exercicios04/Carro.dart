import 'Veiculo.dart';

class Carro extends Veiculo {
  double quilometragemAno;
  int numeroPortas;

  Carro(
      {required super.marca,
      required super.modelo,
      required super.anoFabricacao,
      required super.precoBase,
      required this.quilometragemAno,
      required this.numeroPortas});

  // define o estado do carro (Novo, Seminovo ou Usado)
  String get estado {
    String estado = 'Novo';
    if (this.quilometragemAno > 20000) {
      estado = 'Usado';
    }
    if (15000 <= this.quilometragemAno && this.quilometragemAno <= 20000) {
      estado = 'Seminovo';
    }
    return estado;
  }

  // calcula o preço adicional
  double get precoAdicional {
    return this.numeroPortas * 1000 + this.quilometragemAno * 0.01 + this.precoBase;
  }

  // calcula o preço total
  double get precoTotal {
    return this.precoBase + this.precoAdicional;
  }

  @override
  String toString() {
    return '''
---------------Carro---------------
    Marca: $marca
    Modelo: $modelo
    Ano de fabricação: $anoFabricacao
    Quilometragem por ano: $quilometragemAno
    Número de portas: $numeroPortas
    Estado: $estado
    Preço base: $precoBase
    Preço adicional: $precoAdicional
    Preço total: $precoTotal
----------------------------------
''';
  }
}
