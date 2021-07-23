import 'package:feature_chat_impl/feature_chat_impl.dart';
import 'package:flutter/material.dart';

import 'message/message_skeleton.dart';

class MessageText extends StatelessWidget {
  const MessageText({Key? key, required this.text, required this.shortInfo})
      : super(key: key);

  final InlineSpan text;
  final Widget shortInfo;

  @override
  Widget build(BuildContext context) {
    return MessageSkeleton(
      content: Text.rich(text),
      // content: Container(color: Colors.blue, height: 30,),
      shortInfo: Padding(
        padding: const EdgeInsets.only(left: 4, top: 4),
        child: shortInfo,
      ),
    );
  }
}
