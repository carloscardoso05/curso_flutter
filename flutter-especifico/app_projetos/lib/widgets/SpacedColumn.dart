import 'package:flutter/material.dart';

class SpacedColumn extends StatelessWidget {
  SpacedColumn({
    super.key,
    this.children = const [],
    this.space,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.verticalDirection = VerticalDirection.down,
  });
  List<Widget> children;
  EdgeInsetsGeometry? space;
  CrossAxisAlignment crossAxisAlignment;
  MainAxisAlignment mainAxisAlignment;
  VerticalDirection verticalDirection;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: crossAxisAlignment,
      mainAxisAlignment: mainAxisAlignment,
      verticalDirection: verticalDirection,
      children: [...children]
          .map((child) =>
              Padding(padding: space ?? const EdgeInsets.all(0), child: child))
          .toList(),
    );
  }
}
