import 'package:flutter/material.dart';

class Task {
  Task({required this.description, this.done = false, this.duration});
  String description;
  bool done;
  DateTimeRange? duration;
}
