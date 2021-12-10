library chat_theme;

import 'package:flutter/material.dart';
import 'package:tg_theme/tg_theme.dart';

@immutable
class ChatThemeData implements ITgThemeData {
  const ChatThemeData({
    required this.bubbleColor,
    required this.bubbleTextStyle,
    required this.bubbleOutgoingColor,
    required this.backgroundColor,
  });

  factory ChatThemeData.def({required BuildContext context}) => ChatThemeData(
        // bubbleOutgoingColor: const Color.fromARGB(255, 58, 139, 216),
        bubbleOutgoingColor: const Color.fromARGB(255, 234, 234, 234),
        bubbleColor: const Color.fromARGB(255, 240, 240, 240),
        backgroundColor: Colors.white,
        bubbleTextStyle: Theme.of(context).textTheme.subtitle1!,
      );

  final Color bubbleOutgoingColor;
  final Color bubbleColor;
  final Color backgroundColor;
  final TextStyle bubbleTextStyle;
}
