import 'package:app_projetos/models/RolesEnum.dart';
import 'package:app_projetos/models/UserModel.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EditUserPage extends StatefulWidget {
  EditUserPage({super.key, required this.uid, this.user});
  ProjectUser? user;
  String uid;

  @override
  State<EditUserPage> createState() => _EditUserPageState();
}

class _EditUserPageState extends State<EditUserPage> {
  final DateFormat dateFormat = DateFormat('dd/MM/yyyy');

  String _name = '';
  Role _role = Role.Desenvolvedor;
  DateTime _entryDate = DateTime.now();
  bool _active = false;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: _entryDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(DateTime.now().year + 2));
    if (picked != null && picked != _entryDate) {
      setState(() {
        _entryDate = picked;
      });
    }
  }

  @override
  void initState() {
    if (widget.user != null) {
      ProjectUser user = widget.user!;
      _name = user.name;
      _role = user.role;
      _entryDate = user.entryDate;
      _active = user.active;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Editar dados')),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextFormField(
              initialValue: _name,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Nome',
              ),
              onChanged: (value) => setState(() {
                _name = value;
              }),
            ),
            DropdownButtonFormField(
              value: _role,
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
              onChanged: (value) {
                _role = value!;
              },
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
                  onPressed: () => _selectDate(context),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 15,
                    ),
                    child: Text(
                      dateFormat.format(_entryDate),
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
                  value: _active,
                  onChanged: (value) => setState(
                    () {
                      _active = value;
                    },
                  ),
                ),
              ],
            ),
            ElevatedButton(
                onPressed: () async {
                  final DatabaseReference ref = FirebaseDatabase.instance
                      .ref()
                      .child('users')
                      .child(widget.uid);

                  ProjectUser user = ProjectUser(
                    id: widget.uid,
                    name: _name,
                    role: _role,
                    entryDate: _entryDate,
                    active: _active,
                  );

                  await ref.set(user.toJson());
                  Navigator.pop(context);
                },
                child: const Text('Salvar'))
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
