import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

class TextBackground extends SingleChildRenderObjectWidget {
  const TextBackground({
    required this.backgroundColor,
    required this.margin,
    required super.child,
    super.key,
  });

  final Color backgroundColor;
  final double margin;

  @override
  _BackgroundRender createRenderObject(BuildContext context) {
    return _BackgroundRender(
      backgroundColor: backgroundColor,
      margin: margin,
    );
  }

  @override
  void updateRenderObject(
    BuildContext context,
    _BackgroundRender renderObject,
  ) {
    renderObject
      ..backgroundColor = backgroundColor
      ..margin = margin;
  }
}

class _BackgroundRender extends RenderProxyBoxWithHitTestBehavior {
  _BackgroundRender({
    required Color backgroundColor,
    required double margin,
  })  : _backgroundColor = backgroundColor,
        _margin = margin;

  final Path _backgroundPath = Path();
  late Paint _backgroundPaint = _createBackgroundPaint();

  Color _backgroundColor;

  // ignore: avoid_setters_without_getters
  set backgroundColor(Color value) {
    if (_backgroundColor == value) {
      return;
    }
    _backgroundColor = value;
    _backgroundPaint = _createBackgroundPaint();
    markNeedsPaint();
  }

  double _margin;

  // ignore: avoid_setters_without_getters
  set margin(double value) {
    if (_margin == value) {
      return;
    }
    _margin = value;
    markNeedsLayout();
  }

  @override
  void performLayout() {
    super.performLayout();

    final RenderParagraph child = this.child as RenderParagraph;
    final List<TextBox> boxesForSelection = child.getBoxesForSelection(
      TextSelection(
        baseOffset: 0,
        extentOffset: child.text.toPlainText().length,
      ),
    );

    _backgroundPath.reset();
    for (final TextBox box in boxesForSelection.reversed) {
      final Rect rect = Rect.fromLTRB(
        box.left - _margin,
        box.top - _margin,
        box.right + _margin,
        box.bottom + _margin,
      );
      _backgroundPath.addRRect(
        RRect.fromRectXY(rect, _cornerRadius, _cornerRadius),
      );
    }
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    context.canvas.save();
    context.canvas.translate(offset.dx, offset.dy);
    context.canvas.drawPath(_backgroundPath, _backgroundPaint);
    context.canvas.restore();
    super.paint(context, offset);
  }

  Paint _createBackgroundPaint() {
    return Paint()..color = _backgroundColor;
  }

  static const double _cornerRadius = 16;
}
