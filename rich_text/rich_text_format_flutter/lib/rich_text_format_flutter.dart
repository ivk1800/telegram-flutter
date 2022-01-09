library rich_text_format_flutter;

import 'package:flutter/material.dart';
import 'package:rich_text_format/rich_text_format.dart' as rt;

extension RichTextExt on rt.RichText {
  InlineSpan toInlineSpan(BuildContext context) {
    return TextSpan(
      children: entities.map((rt.Entity e) {
        return e.types.first.map(
          planeText: (_) {
            return TextSpan(text: e.text);
          },
          textUrl: (rt.TextUrl value) {
            return TextSpan(
              text: e.text,
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
              ),
            );
          },
        );
      }).toList(),
    );
  }
}
