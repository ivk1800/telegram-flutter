import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'chat_context.dart';

class MessageHeader extends StatelessWidget {
  const MessageHeader({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    final ChatContextData chatContextData = ChatContext.of(context);
    final ThemeData themeData = Theme.of(context);
    return Padding(
      padding: EdgeInsets.only(
          left: chatContextData.horizontalPadding,
          right: chatContextData.horizontalPadding,
          bottom: 8,
          top: 8),
      child: Text(
        title,
        style: themeData.textTheme.button!
            .copyWith(color: themeData.colorScheme.primary),
      ),
    );
  }
}
