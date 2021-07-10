import 'package:flutter/widgets.dart';

class ChatContext extends StatelessWidget {
  const ChatContext({Key? key, required this.data, required this.child})
      : super(key: key);

  final ChatContextData data;

  final Widget child;

  static ChatContextData of(BuildContext context) {
    final _InheritedContext? inheritedTheme =
        context.dependOnInheritedWidgetOfExactType<_InheritedContext>();
    final ChatContextData theme = inheritedTheme!.theme.data;
    return theme;
  }

  @override
  Widget build(BuildContext context) {
    return _InheritedContext(
      theme: this,
      child: child,
    );
  }
}

class ChatContextData {
  const ChatContextData.raw({
    required this.maxWidth,
    required this.maxMediaHeight,
    required this.width,
    required this.horizontalPadding,
  });

  factory ChatContextData.desktop({required double maxWidth}) =>
      ChatContextData.raw(
        width: maxWidth,
        horizontalPadding: 8.0,
        maxWidth: 500,
        maxMediaHeight: 450,
      );

  final double maxWidth;
  final double maxMediaHeight;
  final double width;
  final double horizontalPadding;
}

class _InheritedContext extends InheritedTheme {
  const _InheritedContext({
    Key? key,
    required this.theme,
    required Widget child,
  })  : assert(theme != null),
        super(key: key, child: child);

  final ChatContext theme;

  @override
  Widget wrap(BuildContext context, Widget child) {
    return ChatContext(data: theme.data, child: child);
  }

  @override
  bool updateShouldNotify(_InheritedContext old) =>
      theme.data != old.theme.data;
}
