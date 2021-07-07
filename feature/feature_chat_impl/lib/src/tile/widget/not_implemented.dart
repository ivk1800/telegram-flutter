import 'package:feature_chat_impl/src/widget/theme/chat_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class NotImplementedWidget extends StatelessWidget {
  const NotImplementedWidget({Key? key, required this.type}) : super(key: key);

  final String type;

  @override
  Widget build(BuildContext context) {
    return Text(
      type,
      style: ChatTheme.of(context)
          .bubbleTextStyle
          .copyWith(color: Colors.redAccent),
    );
  }
}
