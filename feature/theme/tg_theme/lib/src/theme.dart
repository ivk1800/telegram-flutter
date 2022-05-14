import 'package:flutter/widgets.dart';

import 'theme_data.dart';

class TgTheme extends StatelessWidget {
  const TgTheme({
    super.key,
    required this.data,
    required this.child,
  });

  final TgThemeData data;

  final Widget child;

  static TgThemeData of(BuildContext context) {
    final _InheritedTheme? inheritedTheme =
        context.dependOnInheritedWidgetOfExactType<_InheritedTheme>();
    return inheritedTheme!.theme.data;
  }

  @override
  Widget build(BuildContext context) {
    return _InheritedTheme(
      theme: this,
      child: child,
    );
  }
}

class _InheritedTheme extends InheritedTheme {
  const _InheritedTheme({
    required this.theme,
    required super.child,
  });

  final TgTheme theme;

  @override
  Widget wrap(BuildContext context, Widget child) {
    return TgTheme(data: theme.data, child: child);
  }

  @override
  bool updateShouldNotify(_InheritedTheme old) => theme.data != old.theme.data;
}
