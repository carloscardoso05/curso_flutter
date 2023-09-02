import 'package:app_projetos/models/RolesEnum.dart';
import 'package:app_projetos/models/UserModel.dart';
import 'package:flutter/material.dart';

class ProjectUserFormState extends ChangeNotifier {
  ProjectUser? projectUser;
  String name = '';
  Role role = Role.Desenvolvedor;
  bool active = false;
  DateTime entryDate = DateTime.now();
  String? nameError;
  bool noErrors = false;

  ProjectUserFormState({this.projectUser}) {
    if (projectUser != null) {
      name = projectUser!.name;
      role = projectUser!.role;
      active = projectUser!.active;
      entryDate = projectUser!.entryDate;
      validateData();
      notifyListeners();
    }
  }

  void validateData() {
    noErrors = name.isNotEmpty && nameError == null;
  }

  void setName(String newName) {
    name = newName;
    nameError = name.isEmpty ? 'O nome não pode ser vazio' : null;
    validateData();
    notifyListeners();
  }

  void setRole(Role newRole) {
    role = newRole;
    notifyListeners();
  }

  void setActive(bool newValue) {
    active = newValue;
    notifyListeners();
  }

  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: entryDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(DateTime.now().year + 2));
    if (picked != null && picked != entryDate) {
      entryDate = picked;
      notifyListeners();
    }
  }
}
