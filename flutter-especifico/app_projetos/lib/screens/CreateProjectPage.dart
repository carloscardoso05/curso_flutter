import 'package:app_projetos/models/ProjectModel.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import '../utilities/DateTimeFormat.dart';

class CreateProjectPage extends StatefulWidget {
  CreateProjectPage({super.key, required this.uid});
  String uid;

  @override
  State<CreateProjectPage> createState() => _CreateProjectPageState();
}

class _CreateProjectPageState extends State<CreateProjectPage> {
  String _name = '';
  int _membersQuantity = 1;
  String? _quantityError;
  String? _nameError;
  DateTime _deliverDate = DateTime.now();
  bool validData() {
    return _quantityError == null && _nameError == null && _name.isNotEmpty;
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: _deliverDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(DateTime.now().year + 2));
    if (picked != null && picked != _deliverDate) {
      setState(() {
        _deliverDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                labelText: 'Nome do projeto',
                errorText: _nameError,
              ),
              onChanged: (value) => setState(() {
                if (value.isEmpty) {
                  setState(() {
                    _nameError = 'O nome não pode ser vazio';
                  });
                } else {
                  setState(() {
                    _nameError == null;
                    _name = value;
                  });
                }
              }),
            ),
            TextFormField(
              initialValue: '1',
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                labelText: 'Quantidade de membros',
                errorText: _quantityError,
              ),
              onChanged: (value) => setState(() {
                int? quantity = int.tryParse(value);
                if (quantity == null) {
                  setState(() {
                    _quantityError = 'Valor inválido';
                  });
                } else if (quantity < 1) {
                  setState(() {
                    _quantityError = 'Não pode ser menor do que 1';
                  });
                } else {
                  _quantityError = null;
                  _membersQuantity = quantity;
                }
              }),
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
                  onPressed: () => _selectDate(context),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 15,
                    ),
                    child: Text(
                      dateFormat.format(_deliverDate),
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                ),
              ],
            ),
            ElevatedButton(
              onPressed: () async {
                DatabaseReference ref =
                    FirebaseDatabase.instance.ref().child('projects').push();
                String? projectId = ref.key;
                if (projectId != null && validData()) {
                  Project project = Project(
                    id: projectId,
                    managerId: widget.uid,
                    name: _name,
                    deliverDate: _deliverDate,
                    delivered: false,
                    membersQuantity: _membersQuantity,
                  );
                  await ref.set(project.toJson());
                  Navigator.pop(context);
                }
              },
              child: const Text('Adicionar projeto'),
            )
          ]
              .map((widget) => Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: widget,
                  ))
              .toList(),
        ),
      ),
    );
  }
}
