import 'Carro.dart';
import 'Moto.dart';
main() {
  Carro fiatUno = Carro(marca: 'Fiat', modelo: 'Uno', anoFabricacao: 2005, quilometragemAno: 17000, numeroPortas: 4, precoBase: 46000);
  print('''
  ${fiatUno.modelo}
  Preço total: ${fiatUno.precoTotal}
  Preço adicional: ${fiatUno.precoAdicional}
  Preço base: ${fiatUno.precoBase}
  ''');

  Moto honda = Moto(marca: 'Honda', modelo: 'H300', anoFabricacao: 2020, cilindradas: 260, temPartidaEletrica: true, precoBase: 25000);
  print('''
  ${honda.modelo}
  Preço total: ${honda.precoTotal}
  Preço adicional: ${honda.precoAdicional}
  Preço base: ${honda.precoBase}
  ''');
}