import 'package:app_projetos/models/RolesEnum.dart';

class ProjectUser {
  final String id;
  final String name;
  final Role role;
  final DateTime entryDate;
  final bool active;

  ProjectUser.fromJson(Map data)
      : this(
          id: data['id'],
          name: data['name'],
          role: Role.values
              .firstWhere((element) => element.toString() == data['role']),
          entryDate: DateTime.parse(data['entryDate']),
          active: data['active'],
        );

  ProjectUser({
    required this.id,
    required this.name,
    required this.role,
    required this.entryDate,
    required this.active,
  });

  Map toJson() {
    return {
      'id': id,
      'name': name,
      'role': role.toString(),
      'entryDate': entryDate.toString(),
      'active': active,
    };
  }
}
