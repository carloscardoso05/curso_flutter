import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => _State(),
      builder: (context, child) {
        return MaterialApp(
          home: Scaffold(
            appBar: AppBar(),
            body: Container(
              padding: const EdgeInsets.all(20),
              alignment: Alignment.topCenter,
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  children: [
                    Selector<_State, int>(
                      builder: (context, count, child) {
                        print('int');
                        return Text('$count');
                      },
                      selector: (context, state) => state.count,
                    ),
                    Builder(
                      builder: (context) {
                        _State state = context.read<_State>();
                        return Column(
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                state.increments();
                              },
                              child: const Icon(Icons.add),
                            ),
                            TextFormField(
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Item',
                                hintText: 'Adicionar item',
                              ),
                              onChanged: (value) {
                                state.setItem(value);
                              },
                              onEditingComplete: () {
                                state.addItem();
                              },
                            ),
                            ElevatedButton(
                              onPressed: () {
                                state.addItem();
                              },
                              child: const Text('Adicionar item'),
                            ),
                          ]
                              .map((widget) => Padding(
                                    padding: const EdgeInsets.only(bottom: 20),
                                    child: widget,
                                  ))
                              .toList(),
                        );
                      },
                    ),
                    // Exibe os itens
                    Selector<_State, List<String>>(
                      builder: (context, items, child) {
                        print('list');
                        return Column(
                          children: items.indexed
                              .map(
                                (item) => ListTile(
                                  title: Text('Item ${item.$1}: ${item.$2}'),
                                ),
                              )
                              .toList(),
                        );
                      },
                      selector: (context, state) => state.items.toList(),
                      // '.toList()' é usado pois o selector precisa receber um objeto imutável
                    ),
                  ]
                      .map(
                        (widget) => Padding(
                          padding: const EdgeInsets.only(bottom: 20),
                          child: widget,
                        ),
                      )
                      .toList(),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class _State extends ChangeNotifier {
  int count = 0;
  String item = '';
  List<String> items = [];

  void increments() {
    count += 1;
    notifyListeners();
  }

  void setItem(String item) {
    this.item = item;
    notifyListeners();
  }

  void addItem() {
    items.add(item);
    notifyListeners();
  }
}
