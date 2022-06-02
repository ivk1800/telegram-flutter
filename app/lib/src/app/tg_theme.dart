import 'package:chat_theme/chat_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:tg_theme/tg_theme.dart';

class TgAppTheme extends StatelessWidget {
  const TgAppTheme({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return TgTheme(
      data: TgThemeData(
        textTheme: TgTextTheme.light(),
        themes: <Type, ITgThemeData>{
          ChatThemeData: ChatThemeData.light(context: context),
        },
      ),
      child: child,
    );
  }
}
