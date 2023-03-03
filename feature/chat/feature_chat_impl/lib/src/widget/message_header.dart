import 'package:flutter/material.dart';

import 'chat_context.dart';

class MessageHeader extends StatelessWidget {
  const MessageHeader({super.key, required this.title});

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
        top: 8,
      ),
      child: Text(
        title,
        style: themeData.textTheme.labelLarge!
            .copyWith(color: themeData.colorScheme.primary),
      ),
    );
  }
}
