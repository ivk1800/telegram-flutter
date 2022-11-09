import 'package:flutter/material.dart';
import 'package:rich_text_format/rich_text_format.dart' as rt;
import 'custom_emoji_container.dart';

extension RichTextExt on rt.RichText {
  InlineSpan toInlineSpan(BuildContext context) {
    return TextSpan(
      children: entities.map((rt.Entity e) {
        // TODO support multiple types
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
          customEmoji: (rt.CustomEmoji value) {
            return WidgetSpan(
              alignment: PlaceholderAlignment.middle,
              child: CustomEmojiContainer(
                emoji: e.text,
                // TODO: sync with actual text style
                style: DefaultTextStyle.of(context).style,
                child: const Placeholder(),
              ),
            );
          },
        );
      }).toList(),
    );
  }
}
