import 'dart:async';

import 'package:flutter/material.dart';

class Timer extends StatefulWidget {
  const Timer({super.key, required this.duration});
  final Duration duration;

  Stream<int> countDown() async* {
    for (int i = duration.inSeconds; i >= 0; i--) {
      yield i;
      await Future.delayed(const Duration(seconds: 1));
    }
  }

  @override
  State<Timer> createState() => _TimerState();
}

class _TimerState extends State<Timer> {
  @override
  Widget build(BuildContext context) {
    final int totalTime = widget.duration.inSeconds;
    return StreamBuilder(
      stream: widget.countDown(),
      initialData: totalTime,
      builder: (context, snapshot) {
        int time = snapshot.data as int;
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                time.toString(),
                style: const TextStyle(
                  fontSize: 28,
                ),
              ),
              LinearProgressIndicator(
                value: (time / totalTime),
              ),
            ],
          ),
        );
      },
    );
  }
}
