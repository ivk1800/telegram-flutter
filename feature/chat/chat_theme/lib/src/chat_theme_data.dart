import 'package:flutter/material.dart';
import 'package:tg_theme/tg_theme.dart';

@immutable
class ChatThemeData implements ITgThemeData {
  const ChatThemeData({
    required this.bubbleIncomingColor,
    required this.bubbleTextStyle,
    required this.bubbleOutgoingColor,
    required this.backgroundColor,
    required this.bubbleShortInfoIncomingColor,
    required this.bubbleShortInfoOutgoingColor,
    required this.notificationColor,
    required this.notificationTextColor,
    required this.replyTitle,
    required this.replySubtitle,
    required this.bubbleOutgoingBorderColor,
    required this.bubbleIncomingBorderColor,
  });

  factory ChatThemeData.light({required BuildContext context}) {
    final TgTextTheme textTheme = TgTextTheme.light();
    return ChatThemeData(
      bubbleIncomingBorderColor: Colors.grey.shade200,
      bubbleOutgoingBorderColor: Colors.grey.shade200,
      bubbleOutgoingColor: const Color.fromARGB(255, 239, 254, 221),
      bubbleIncomingColor: Colors.white,
      backgroundColor: Colors.white,
      bubbleShortInfoIncomingColor: const Color.fromARGB(255, 161, 170, 179),
      bubbleShortInfoOutgoingColor: const Color.fromARGB(255, 98, 172, 85),
      bubbleTextStyle: Theme.of(context).textTheme.subtitle1!,
      notificationTextColor: Colors.white,
      notificationColor: const Color.fromARGB(100, 114, 131, 145),
      replyTitle: textTheme.subtitle3.copyWith(color: kPrimaryColor),
      replySubtitle: textTheme.subtitle2,
    );
  }

  final Color bubbleOutgoingColor;
  final Color bubbleShortInfoOutgoingColor;
  final Color bubbleIncomingColor;
  final Color bubbleShortInfoIncomingColor;
  final Color backgroundColor;
  final TextStyle bubbleTextStyle;
  final Color bubbleIncomingBorderColor;
  final Color bubbleOutgoingBorderColor;

  final Color notificationColor;
  final Color notificationTextColor;

  final TextStyle replyTitle;
  final TextStyle replySubtitle;
}
