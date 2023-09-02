import 'package:app_projetos/models/RolesEnum.dart';
import 'package:app_projetos/models/UserModel.dart';
import 'package:app_projetos/states/ProjectUserFormState.dart';
import 'package:app_projetos/states/ProjectUserState.dart';
import 'package:app_projetos/states/UserState.dart';
import 'package:app_projetos/utilities/DateTimeFormat.dart';
import 'package:app_projetos/widgets/SpacedColumn.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditProjectUserPage extends StatelessWidget {
  EditProjectUserPage({super.key, this.projectUser});
  ProjectUser? projectUser;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ProjectUserFormState>(
        create: (context) => ProjectUserFormState(projectUser: projectUser),
        builder: (context, child) {
          return Scaffold(
            appBar: AppBar(title: const Text('Editar dados')),
            body: Container(
              padding: const EdgeInsets.all(20),
              child: Consumer<ProjectUserFormState>(
                  builder: (context, formState, child) {
                return SpacedColumn(
                  space: const EdgeInsets.only(bottom: 20),
                  children: [
                    TextFormField(
                      initialValue: formState.name,
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        labelText: 'Nome',
                        errorText: formState.nameError,
                      ),
                      onChanged: (value) => formState.setName(value),
                    ),
                    DropdownButtonFormField(
                      value: formState.role,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Cargo',
                        hintText: 'Selecione um cargo',
                      ),
                      items: const [
                        DropdownMenuItem(
                          value: Role.Desenvolvedor,
                          child: Text('Desenvolvedor'),
                        ),
                        DropdownMenuItem(
                          value: Role.Gerente,
                          child: Text('Gerente'),
                        ),
                        DropdownMenuItem(
                          value: Role.Testador,
                          child: Text('Testador'),
                        ),
                      ],
                      onChanged: (value) => formState.setRole(value!),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(right: 10),
                          child: Text(
                            'Data de entrada',
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                        OutlinedButton(
                          onPressed: () => formState.selectDate(context),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 15,
                            ),
                            child: Text(
                              dateFormat.format(formState.entryDate),
                              style: const TextStyle(fontSize: 16),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Ativo',
                          style: TextStyle(fontSize: 16),
                        ),
                        Switch(
                          value: formState.active,
                          onChanged: (value) => formState.setActive(value),
                        ),
                      ],
                    ),
                    ChangeNotifierProvider<ProjectUserState>(
                      create: (context) {
                        String uid = context.read<UserState>().user!.uid;
                        return ProjectUserState(uid: uid);
                      },
                      builder: (context, child) {
                        return Selector<ProjectUserState, String>(
                            selector: (context, userState) => userState.uid,
                            builder: (context, uid, child) {
                              bool noErrors =
                                  context.read<ProjectUserFormState>().noErrors;
                              return ElevatedButton(
                                  onPressed: () async {
                                    if (!noErrors) return;
                                    final DatabaseReference ref =
                                        FirebaseDatabase.instance
                                            .ref()
                                            .child('users')
                                            .child(uid);

                                    ProjectUser user = ProjectUser(
                                      id: uid,
                                      name: formState.name,
                                      role: formState.role,
                                      entryDate: formState.entryDate,
                                      active: formState.active,
                                    );

                                    await ref.set(user.toJson());
                                    Navigator.pop(context);
                                  },
                                  child: const Text('Salvar'));
                            });
                      },
                    )
                  ],
                );
              }),
            ),
          );
        });
  }
}
