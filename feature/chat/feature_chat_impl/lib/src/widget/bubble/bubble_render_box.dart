// ignore_for_file: cascade_invocations

import 'package:flutter/rendering.dart';

class BubbleRenderBox extends RenderProxyBoxWithHitTestBehavior {
  BubbleRenderBox({
    required Color color,
    required BorderPathProvider borderPathProvider,
  })  : _color = color,
        _borderPathProvider = borderPathProvider,
        super(behavior: HitTestBehavior.opaque) {
    _createBorderPaint();
  }

  Paint? borderPaint;

  BorderPathProvider get borderPathProvider => _borderPathProvider;
  BorderPathProvider _borderPathProvider;

  set borderPathProvider(BorderPathProvider value) {
    if (value == _borderPathProvider) {
      return;
    }
    _borderPathProvider = value;
    _createBorderPaint();
    markNeedsPaint();
  }

  Color get color => _color;
  Color _color;

  set color(Color value) {
    if (value == _color) {
      return;
    }
    _color = value;
    _createBorderPaint();
    markNeedsPaint();
  }

  void _createBorderPaint() {
    borderPaint = Paint()
      ..isAntiAlias = true
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0
      ..color = _color;
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    if (child != null) {
      context.paintChild(child!, offset);
    }

    final Paint? paint = borderPaint;

    if (paint != null) {
      final Canvas canvas = context.canvas;
      canvas.save();
      canvas.translate(offset.dx, offset.dy);
      canvas.drawPath(_borderPathProvider.getPath(size), paint);
      canvas.restore();
    }
  }
}

abstract class BorderPathProvider {
  Path getPath(Size size);
}
