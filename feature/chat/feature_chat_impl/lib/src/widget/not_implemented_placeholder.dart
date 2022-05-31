import 'package:flutter/material.dart';

class NotImplementedPlaceholder extends StatelessWidget {
  const NotImplementedPlaceholder({super.key, this.additional});

  final String? additional;

  @override
  Widget build(BuildContext context) {
    const TextStyle textStyle = TextStyle(color: Colors.white);
    return Center(
      child: Container(
        padding: const EdgeInsets.all(4.0),
        color: Colors.black26,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const Text(
              'not implemented',
              style: textStyle,
            ),
            if (additional != null) Text(additional!, style: textStyle),
          ],
        ),
      ),
    );
  }
}
