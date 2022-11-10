import 'package:flutter/material.dart';
import 'package:rich_text_format/rich_text_format.dart' as rt;
import 'package:rich_text_format_flutter/rich_text_format_flutter.dart';
import 'package:tg_theme/tg_theme.dart';

import 'message/message_wrap.dart';

class MessageText extends StatelessWidget {
  const MessageText({super.key, required this.text, required this.shortInfo});

  final rt.RichText text;
  final Widget shortInfo;

  @override
  Widget build(BuildContext context) {
    return MessageWrap(
      // TODO wrap to DefaultTextStyle for custom emoji
      content: Text.rich(
        text.toInlineSpan(context),
        style: TgTheme.of(context).textTheme.regular,
      ),
      shortInfo: Padding(
        padding: const EdgeInsets.only(left: 4),
        child: shortInfo,
      ),
    );
  }
}
