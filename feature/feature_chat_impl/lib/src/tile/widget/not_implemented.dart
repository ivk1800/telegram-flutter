import 'package:chat_theme/chat_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:tg_theme/tg_theme.dart';

class NotImplementedWidget extends StatelessWidget {
  const NotImplementedWidget({Key? key, required this.type}) : super(key: key);

  final String type;

  @override
  Widget build(BuildContext context) {
    final ChatThemeData theme = TgTheme.of(context).themeOf();
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        type,
        style: theme.bubbleTextStyle.copyWith(color: Colors.redAccent),
      ),
    );
  }
}
