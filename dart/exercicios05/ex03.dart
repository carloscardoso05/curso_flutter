import 'dart:math';
Future<String> tarefa1() async {
  final int duration = Random().nextInt(5) + 1;
  final String data = await Future.delayed(Duration(seconds: duration), () => 'Tarefa 1 concluída em $duration segundos');
  return data;
}
Future<String> tarefa2() async {
  final int duration = Random().nextInt(5) + 1;
  final String data = await Future.delayed(Duration(seconds: duration), () => 'Tarefa 2 concluída em $duration segundos');
  return data;
}
Future<String> tarefa3() async {
  final int duration = Random().nextInt(5) + 1;
  final String data = await Future.delayed(Duration(seconds: duration), () => 'Tarefa 3 concluída em $duration segundos');
  return data;
}

main() async {
  final List<Future<String>> listaTarefas = [tarefa1(), tarefa2(), tarefa3()];
  final futuresTarefas = await Future.wait(listaTarefas).then((tarefas) {
    for (final tarefa in tarefas) {
      print(tarefa);
    }
  });
}