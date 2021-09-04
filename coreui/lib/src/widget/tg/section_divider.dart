import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SectionDivider extends StatelessWidget {
  const SectionDivider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(color: Theme.of(context).dividerColor),
        ),
        color: Theme.of(context).hoverColor,
      ),
      height: 12,
    );
  }
}
