Future<String> fetchData() async {
  final String data = await Future.delayed(Duration(seconds: 3), () => 'Dados obtidos');
  return data;
}

main() {
  final Future<String> serverData = fetchData();
  serverData.then((data) => print(data));
}