import 'package:app_projetos/models/ProjectModel.dart';
import 'package:app_projetos/states/ProjectFormState.dart';
import 'package:app_projetos/states/UserState.dart';
import 'package:app_projetos/utilities/DateTimeFormat.dart';
import 'package:app_projetos/widgets/SpacedColumn.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CreateProjectPage extends StatelessWidget {
  const CreateProjectPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ProjectFormState>(
        create: (context) => ProjectFormState(),
        builder: (context, child) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Criar projeto'),
            ),
            body: Container(
              padding: const EdgeInsets.all(20),
              child: Consumer<ProjectFormState>(
                builder: (context, formState, child) {
                  return SpacedColumn(
                    space: const EdgeInsets.only(bottom: 20),
                    children: [
                      TextField(
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          labelText: 'Nome do projeto',
                          errorText: formState.nameError,
                        ),
                        onChanged: (value) => formState.setName(value),
                      ),
                      TextFormField(
                        initialValue: '1',
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          labelText: 'Quantidade de membros',
                          errorText: formState.quantityError,
                        ),
                        onChanged: (value) => formState.setQuantity(value),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(right: 10),
                            child: Text(
                              'Data de entrega',
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
                                dateFormat.format(formState.deliverDate),
                                style: const TextStyle(fontSize: 16),
                              ),
                            ),
                          )
                        ],
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          if (!formState.noErrors) return;
                          DatabaseReference ref = FirebaseDatabase.instance
                              .ref()
                              .child('projects')
                              .push();
                          String? projectId = ref.key;
                          String uid = context.read<UserState>().user!.uid;
                          if (projectId != null) {
                            Project project = Project(
                              id: projectId,
                              managerId: uid,
                              name: formState.name,
                              deliverDate: formState.deliverDate,
                              delivered: formState.delivered,
                              membersQuantity: formState.membersQuantity,
                            );
                            await ref.set(project.toJson());
                            Navigator.pop(context);
                          }
                        },
                        child: const Text('Adicionar projeto'),
                      )
                    ],
                  );
                },
              ),
            ),
          );
        });
  }
}
