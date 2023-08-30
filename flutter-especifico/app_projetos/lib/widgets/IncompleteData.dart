import 'package:flutter/material.dart';
import '../screens/EditUserPage.dart';

class IncompleteData extends StatelessWidget {
  IncompleteData({super.key, required this.uid});
  String uid;
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
                builder: (contexto) => EditUserPage(uid: uid),
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
