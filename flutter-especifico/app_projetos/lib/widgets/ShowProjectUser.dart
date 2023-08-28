import 'package:flutter/material.dart';
import '../models/RolesEnum.dart';
import '../models/UserModel.dart';
import '../utilities/DateTimeFormat.dart';

class ShowProjectUser extends StatelessWidget {
  final ProjectUser user;

  ShowProjectUser({
    super.key,
    required this.user,
  });

  Map<Role, String> roles = {
    Role.Desenvolvedor: 'Desenvolvedor',
    Role.Gerente: 'Gerente',
    Role.Testador: 'Testador',
  };

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Nome: ${user.name}',
          style: const TextStyle(fontSize: 16),
        ),
        Text(
          'Cargo: ${roles[user.role]}',
          style: const TextStyle(fontSize: 16),
        ),
        Text(
          'Entrou em: ${dateFormat.format(user.entryDate)}',
          style: const TextStyle(fontSize: 16),
        ),
        Text(
          'Ativo: ${user.active ? "Sim" : "Não"}',
          style: const TextStyle(fontSize: 16),
        ),
      ],
    );
  }
}
