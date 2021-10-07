import 'package:flutter/foundation.dart';

@immutable
class TgThemeData {
  const TgThemeData({
    required Map<Type, ITgThemeData> themes,
  }) : _themes = themes;

  final Map<Type, ITgThemeData> _themes;

  T themeOf<T extends ITgThemeData>() {
    final ITgThemeData? theme = _themes[T];
    assert(theme != null, 'theme of type [$T] not provided');
    return theme as T;
  }
}

abstract class ITgThemeData {}
