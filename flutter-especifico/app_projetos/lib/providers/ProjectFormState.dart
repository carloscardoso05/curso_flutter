import 'package:flutter/material.dart';

class ProjectFormState extends ChangeNotifier {
  String id = '';
  String managerId = '';
  String name = '';
  DateTime deliverDate = DateTime.now();
  bool delivered = false;
  int membersQuantity = 1;
  String? quantityError;
  String? nameError;

  bool noErrors() => nameError == null && quantityError == null;

  void setId(String value) {
    id = value;
    notifyListeners();
  }

  void setManagerId(String value) {
    managerId = value;
    notifyListeners();
  }

  void setName(String value) {
    if (value.isEmpty) {
      nameError = 'Nome não pode ser vazio';
    } else {
      nameError = null;
    }
    name = value;
    notifyListeners();
  }

  void setQuantity(String value) {
    int? quantity = int.tryParse(value);
    if (quantity == null) {
      quantityError = 'Valor inválido';
    } else if (quantity < 1) {
      quantityError = 'Não pode ser menor do que 1';
    } else {
      quantityError = null;
      membersQuantity = quantity;
    }
    notifyListeners();
  }

  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: deliverDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(DateTime.now().year + 2));
    if (picked != null && picked != deliverDate) {
      deliverDate = picked;
    }
    notifyListeners();
  }
}
