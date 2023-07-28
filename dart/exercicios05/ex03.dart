import 'dart:math';
//tarefa com duração aleatória
Future<String> tarefa() async {
  final int duration = Random().nextInt(5) + 1;
  final String data = await Future.delayed(Duration(seconds: duration), () => 'Tarefa 1 concluída em $duration segundos');
  return data;
}

main() async {
  final List<Future<String>> listaTarefas = [tarefa(), tarefa(), tarefa()];

  //aguarda todas as tarefas serem concluídas
  final futuresTarefas = await Future.wait(listaTarefas).then((tarefas) {
    for (final tarefa in tarefas) {
      print(tarefa);
    }
  });
}