import 'package:chat_theme/chat_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:tg_theme/tg_theme.dart';

class TgAppTheme extends StatelessWidget {
  const TgAppTheme({required this.child, Key? key}) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return TgTheme(
      data: TgThemeData(themes: <Type, ITgThemeData>{
        ChatThemeData: ChatThemeData.def(context: context),
      }),
      child: child,
    );
  }
}
