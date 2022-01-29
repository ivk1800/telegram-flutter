import 'dart:ui';

import 'package:flutter/cupertino.dart';

abstract class CompactLayoutStrategy {
  bool process(BoxConstraints constraints);

  const factory CompactLayoutStrategy.create() = _DefaultCompactLayoutStrategy;
}

class _DefaultCompactLayoutStrategy implements CompactLayoutStrategy {
  const _DefaultCompactLayoutStrategy();

  @override
  bool process(BoxConstraints constraints) {
    final SingletonFlutterWindow window = WidgetsBinding.instance!.window;
    final Size size = window.physicalSize / window.devicePixelRatio;
    return size.shortestSide < 600;
  }
}
