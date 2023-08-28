import 'package:flutter/material.dart';

class CreateProjectPage extends StatefulWidget {
  const CreateProjectPage({super.key});

  @override
  State<CreateProjectPage> createState() => _CreateProjectPageState();
}

class _CreateProjectPageState extends State<CreateProjectPage> {
  String _name = '';
  int _membersQuantity = 0;
  DateTime _deliverDate = DateTime.now();

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
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Nome do projeto',
              ),
              onChanged: (value) => setState(() {
                _name = value;
              }),
            ),
            Row(
              children: [
                ElevatedButton(
                  onPressed: () => setState(() {
                    if (_membersQuantity > 1) _membersQuantity--;
                  }),
                  child: const Icon(Icons.exposure_minus_1_rounded),
                ),
                Text(_membersQuantity.toString()),
                ElevatedButton(
                  onPressed: () => setState(() {
                    _membersQuantity++;
                  }),
                  child: const Icon(Icons.exposure_plus_1_rounded),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
