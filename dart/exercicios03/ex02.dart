import 'dart:io';
import 'dart:math';

main() {
  int tentativas = 4;
  int numero_aleatorio = Random().nextInt(9) + 1;

  while (tentativas > 0) {
    print('Chute um número:');
    int numero = int.parse(stdin.readLineSync().toString());
    if (numero == numero_aleatorio) {
      print('Parabéns, você acertou! O número aleatório é $numero');
      break;
    }
    if (numero < numero_aleatorio) {
      print('O número que você chutou é menor que o número alvo');
    }
    if (numero > numero_aleatorio) {
      print('O número que você chutou é maior que o número alvo');
    }
    tentativas -= 1;
  }
}
