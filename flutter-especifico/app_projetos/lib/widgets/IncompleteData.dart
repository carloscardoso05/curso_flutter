import 'package:flutter/material.dart';
import '../screens/EditProjectUserPage.dart';

class IncompleteData extends StatelessWidget {
  const IncompleteData({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Seus dados ainda não foram cadastrados.',
          style: TextStyle(fontSize: 18),
        ),
        TextButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (contexto) => EditProjectUserPage(),
              ),
            );
          },
          child: const Text(
            'Finalize seu cadastro.',
            style: TextStyle(fontSize: 18),
          ),
        )
      ],
    );
  }
}
