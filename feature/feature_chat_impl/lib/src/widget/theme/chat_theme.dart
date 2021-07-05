import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ChatTheme extends StatelessWidget {
  const ChatTheme({Key? key, required this.data, required this.child})
      : super(key: key);

  final ChatThemeData data;

  final Widget child;

  static ChatThemeData of(BuildContext context) {
    final _InheritedTheme? inheritedTheme =
        context.dependOnInheritedWidgetOfExactType<_InheritedTheme>();
    final ChatThemeData theme = inheritedTheme!.theme.data;
    return theme;
  }

  @override
  Widget build(BuildContext context) {
    return _InheritedTheme(
      theme: this,
      child: child,
    );
  }
}

class ChatThemeData {
  const ChatThemeData.raw({
    required this.bubbleOutgoingColor,
    required this.bubbleColor,
    required this.bubbleTextStyle,
  });

  final Color bubbleOutgoingColor;
  final Color bubbleColor;
  final TextStyle bubbleTextStyle;
}

class _InheritedTheme extends InheritedTheme {
  const _InheritedTheme({
    Key? key,
    required this.theme,
    required Widget child,
  })  : assert(theme != null),
        super(key: key, child: child);

  final ChatTheme theme;

  @override
  Widget wrap(BuildContext context, Widget child) {
    return ChatTheme(data: theme.data, child: child);
  }

  @override
  bool updateShouldNotify(_InheritedTheme old) => theme.data != old.theme.data;
}
