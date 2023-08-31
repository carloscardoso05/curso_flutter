import 'package:app_projetos/models/ProjectModel.dart';
import 'package:app_projetos/providers/ProjectFormState.dart';
import 'package:app_projetos/utilities/DateTimeFormat.dart';
import 'package:app_projetos/widgets/SpacedColumn.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CreateProjectPage extends StatelessWidget {
  CreateProjectPage({super.key, required this.uid});
  String uid;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Criar projeto'),
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            ChangeNotifierProvider(
              create: (context) => ProjectFormState(),
              child: Consumer<ProjectFormState>(
                builder: (context, formState, child) {
                  return SpacedColumn(
                    space: const EdgeInsets.only(bottom: 20),
                    children: [
                      Selector<ProjectFormState, String?>(
                        builder: (context, nameError, child) {
                          return TextField(
                            decoration: InputDecoration(
                              border: const OutlineInputBorder(),
                              labelText: 'Nome do projeto',
                              errorText: nameError,
                            ),
                            onChanged: (value) => formState.setName(value),
                          );
                        },
                        selector: (context, state) => state.nameError,
                      ),
                      Selector<ProjectFormState, String?>(
                        builder: (context, quantityError, child) {
                          return TextFormField(
                            initialValue: '1',
                            decoration: InputDecoration(
                              border: const OutlineInputBorder(),
                              labelText: 'Quantidade de membros',
                              errorText: quantityError,
                            ),
                            onChanged: (value) => formState.setQuantity(value),
                          );
                        },
                        selector: (context, state) => state.quantityError,
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
                          Selector<ProjectFormState, DateTime>(
                            selector: (context, state) => state.deliverDate,
                            builder: (context, deliverDate, child) {
                              return OutlinedButton(
                                onPressed: () => formState.selectDate(context),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 10,
                                    vertical: 15,
                                  ),
                                  child: Text(
                                    dateFormat.format(deliverDate),
                                    style: const TextStyle(fontSize: 16),
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          DatabaseReference ref = FirebaseDatabase.instance
                              .ref()
                              .child('projects')
                              .push();
                          String? projectId = ref.key;
                          if (projectId != null && formState.noErrors()) {
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
          ],
        ),
      ),
    );
  }
}
