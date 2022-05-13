import 'package:flutter/material.dart';
import 'package:rich_text_format/rich_text_format.dart' as rt;
import 'package:rich_text_format_flutter/rich_text_format_flutter.dart';
import 'message/message_skeleton.dart';

class MessageText extends StatelessWidget {
  const MessageText({super.key, required this.text, required this.shortInfo});

  final rt.RichText text;
  final Widget shortInfo;

  @override
  Widget build(BuildContext context) {
    return MessageSkeleton(
      content: Text.rich(
        text.toInlineSpan(context),
      ),
      // content: Container(color: Colors.blue, height: 30,),
      shortInfo: Padding(
        padding: const EdgeInsets.only(left: 4, top: 4),
        child: shortInfo,
      ),
    );
  }
}
