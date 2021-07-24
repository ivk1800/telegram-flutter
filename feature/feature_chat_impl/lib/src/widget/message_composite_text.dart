import 'package:feature_chat_impl/feature_chat_impl.dart';
import 'package:flutter/material.dart';

import 'message_text.dart';

class MessageCaption extends StatelessWidget {
  const MessageCaption({
    Key? key,
    required this.text,
    required this.shortInfo,
  }) : super(key: key);

  final InlineSpan text;
  final Widget shortInfo;

  @override
  Widget build(BuildContext context) {
    final ChatContextData chatContextData = ChatContext.of(context);
    return Padding(
      padding: EdgeInsets.only(
        left: chatContextData.horizontalPadding,
        right: chatContextData.horizontalPadding,
        top: chatContextData.verticalPadding,
        bottom: chatContextData.verticalPadding,
      ),
      child: MessageText(
        text: text,
        shortInfo: shortInfo,
      ),
    );
  }
}
