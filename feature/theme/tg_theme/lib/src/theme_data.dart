import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

import 'text_theme.dart';

@immutable
class TgThemeData {
  const TgThemeData({
    required this.textTheme,
    required Map<Type, ITgThemeData> themes,
  }) : _themes = themes;

  final TgTextTheme textTheme;
  final Map<Type, ITgThemeData> _themes;

  T themeOf<T extends ITgThemeData>() {
    final ITgThemeData? theme = _themes[T];
    assert(theme != null, 'theme of type [$T] not provided');
    return theme as T;
  }
}

abstract class ITgThemeData {}
