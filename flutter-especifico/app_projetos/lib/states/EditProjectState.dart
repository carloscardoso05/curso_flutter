import 'package:flutter/material.dart';

class EditProjectState extends ChangeNotifier {
  String managerId;
  bool delivered = false;

  EditProjectState({required this.managerId}) {
    notifyListeners();
  }

  void setManagerId(String newManagerId) {
    managerId = newManagerId;
    notifyListeners();
  }

  void setDelivered(bool newValue) {
    delivered = newValue;
    notifyListeners();
  }
}
