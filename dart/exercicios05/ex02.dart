Stream<int> countDownStream(int max) async* {
  for (var i = max; i >= 1; i--) {
    yield i;
    await Future.delayed(const Duration(seconds: 1));
  }
}

main() {
  final Stream<int> countDown = countDownStream(5);
  countDown.listen((num) => print(num));
}