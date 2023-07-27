import 'Carro.dart';
import 'Moto.dart';
main() {
  Carro fiatUno = Carro(marca: 'Fiat', modelo: 'Uno', anoFabricacao: 2005, quilometragemAno: 17000, numeroPortas: 4, precoBase: 46000);
  Moto honda = Moto(marca: 'Honda', modelo: 'H300', anoFabricacao: 2020, cilindradas: 260, temPartidaEletrica: true, precoBase: 25000);

  print(fiatUno);
  print(honda);
}