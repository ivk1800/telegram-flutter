import 'package:flutter/material.dart';

class Annotation extends StatelessWidget {
  const Annotation({
    super.key,
    required this.text,
    this.align = TextAlign.start,
  });

  final String text;
  final TextAlign align;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(
        left: 16.0,
        top: 16.0,
        bottom: 16.0,
        right: 8.0,
      ),
      color: theme.hoverColor,
      child: Text(
        text,
        textAlign: align,
        style: theme.textTheme.bodyText2!.copyWith(
          color: theme.textTheme.caption!.color,
        ),
      ),
    );
  }
}
