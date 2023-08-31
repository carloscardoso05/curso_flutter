import 'package:flutter/material.dart';

class SpacedColumn extends StatelessWidget {
  SpacedColumn({super.key, this.children = const [], this.space});
  List<Widget> children;
  EdgeInsetsGeometry? space;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [...children]
          .map((child) =>
              Padding(padding: space ?? const EdgeInsets.all(0), child: child))
          .toList(),
    );
  }
}
