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
    final FlutterView? flutterView = PlatformDispatcher.instance.implicitView;
    final Size physicalSize = flutterView!.physicalSize;
    final double devicePixelRatio = flutterView.devicePixelRatio;
    final Size size = physicalSize / devicePixelRatio;
    return size.shortestSide < 600;
  }
}
