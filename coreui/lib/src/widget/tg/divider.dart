import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' as m;

class Divider extends StatelessWidget {
  const Divider({Key? key, this.indent = DividerIndent.small})
      : super(key: key);

  final DividerIndent indent;

  @override
  Widget build(BuildContext context) {
    return m.Divider(
      indent: _getIndent(),
      height: 1,
    );
  }

  double _getIndent() {
    switch (indent) {
      case DividerIndent.small:
        return 16;
      case DividerIndent.large:
        return 68;
      case DividerIndent.none:
        return 0;
    }
  }
}

enum DividerIndent { none, small, large }
