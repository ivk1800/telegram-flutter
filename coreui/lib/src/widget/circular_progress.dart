import 'package:coreui/coreui.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:vector_math/vector_math.dart' as vm;

class CircularProgress extends SingleChildRenderObjectWidget {
  const CircularProgress({
    required this.progress,
    required this.vsync,
    this.arcMargin = 4,
    this.arcStrokeWidth = 4,
    this.arcColor = Colors.white,
    this.backgroundColor = Colors.black38,
    super.key,
    super.child,
  });

  final TickerProvider vsync;
  final double progress;
  final Color arcColor;
  final Color backgroundColor;
  final double arcMargin;
  final double arcStrokeWidth;

  @override
  RenderObject createRenderObject(BuildContext context) {
    return _CircularProgressRenderBox(
      progress: progress,
      backgroundColor: backgroundColor,
      arcStrokeWidth: arcStrokeWidth,
      arcColor: arcColor,
      vsync: vsync,
      arcMargin: arcMargin,
    );
  }

  @override
  void updateRenderObject(
    BuildContext context,
    _CircularProgressRenderBox renderObject,
  ) {
    renderObject
      ..progress = progress
      ..arcColor = arcColor
      ..arcStrokeWidth = arcStrokeWidth
      ..backgroundColor = backgroundColor
      ..arcMargin = arcMargin;
  }
}

class _CircularProgressRenderBox extends RenderProxyBoxWithHitTestBehavior {
  _CircularProgressRenderBox({
    required double progress,
    required double arcMargin,
    required Color arcColor,
    required Color backgroundColor,
    required double arcStrokeWidth,
    required TickerProvider vsync,
  })  : _vsync = vsync,
        _arcMargin = arcMargin,
        _arcColor = arcColor,
        _backgroundColor = backgroundColor,
        _arcStrokeWidth = arcStrokeWidth,
        _progress = progress;

  late Paint _backgroundPaint = _createBackgroundPaint();

  late double _widthHalf;
  late double _heightHalf;
  late Path _clipPath;
  late Rect _backgroundRect;
  late Rect _progressArcRect;
  final double _progressArcStartAngle = vm.radians(-90);

  late Paint _arcPaint = _createArcPaint();

  // TODO : handle if vsync is updated
  final TickerProvider _vsync;

  // TODO: stop rotation if progress is 1
  late final AnimationController _rotationController = AnimationController(
    duration: const Duration(milliseconds: 4500),
    vsync: _vsync,
  )..addListener(markNeedsPaint);

  late final AnimationController _progressController = AnimationController(
    duration: const Duration(milliseconds: 1000),
    vsync: _vsync,
  )
    ..addListener(markNeedsPaint)
    ..forward();

  late final Animation<int> _rotationAnimation = IntTween(
    begin: 0,
    end: 360,
  ).animate(_rotationController);
  late Animation<double> _progressAnimation = _createProgressAnimation(
    begin: 0,
    end: vm.radians(360 * _progress),
  );

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

  Color _arcColor;

  // ignore: avoid_setters_without_getters
  set arcColor(Color value) {
    if (_arcColor == value) {
      return;
    }
    _arcColor = value;
    _arcPaint = _createArcPaint();
    markNeedsPaint();
  }

  double _arcStrokeWidth;

  // ignore: avoid_setters_without_getters
  set arcStrokeWidth(double value) {
    assert(value >= 0);
    if (_arcStrokeWidth == value) {
      return;
    }
    _arcStrokeWidth = value;
    _arcPaint = _createArcPaint();
    _updateProgressArcRect();
    markNeedsPaint();
  }

  double _arcMargin;

  // ignore: avoid_setters_without_getters
  set arcMargin(double value) {
    assert(value >= 0);
    if (_arcMargin == value) {
      return;
    }
    _arcMargin = value;
    _updateProgressArcRect();
    markNeedsPaint();
  }

  double _progress;

  // ignore: avoid_setters_without_getters
  set progress(double value) {
    assert(value >= 0 && value <= 1.0);
    if (_progress == value) {
      return;
    }
    final double begin = _progressAnimation.value;
    _progressController.reset();
    _progressAnimation = _createProgressAnimation(
      begin: begin,
      end: vm.radians(360 * value),
    );
    _progress = value;

    _progressController.forward();
    markNeedsPaint();
  }

  @override
  void detach() {
    super.detach();
    _rotationController.stop();
    _progressController.stop();
  }

  @override
  void performLayout() {
    super.performLayout();
    assert(size.width == size.height);

    _clipPath = Path()..addOval(Rect.fromLTWH(0, 0, size.width, size.height));
    _backgroundRect = Rect.fromLTRB(0, 0, size.width, size.height);
    _updateProgressArcRect();
    _widthHalf = size.width / 2;
    _heightHalf = size.height / 2;

    // TODO: research the right place to start
    if (!_rotationController.isAnimating) {
      _rotationController.repeat();
    }
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    if (_rotationController.isAnimating) {
      _paintProgress(context, offset);
    }

    super.paint(context, offset);
  }

  void _updateProgressArcRect() {
    _progressArcRect = Rect.fromLTRB(
      _arcStrokeWidth / 2 + _arcMargin,
      _arcStrokeWidth / 2 + _arcMargin,
      size.width - (_arcStrokeWidth / 2) - _arcMargin,
      size.height - (_arcStrokeWidth / 2) - _arcMargin,
    );
  }

  void _paintProgress(PaintingContext context, Offset offset) {
    context.canvas
      ..save()
      ..translate(offset.dx, offset.dy)
      ..clipPath(_clipPath)
      ..drawRect(_backgroundRect, _backgroundPaint)
      ..translate(_widthHalf, _heightHalf)
      ..rotate(vm.radians(_rotationAnimation.value.toDouble()))
      ..translate(-_widthHalf, -_heightHalf)
      ..drawArc(
        _progressArcRect,
        _progressArcStartAngle,
        _progressAnimation.value,
        false,
        _arcPaint,
      )
      ..restore();
  }

  Animation<double> _createProgressAnimation({
    required double begin,
    required double end,
  }) {
    final Curve curve;
    if (begin > end) {
      curve = const StaticCurve();
    } else {
      curve = Curves.ease;
    }
    return Tween<double>(
      begin: begin,
      end: end,
    ).animate(CurvedAnimation(parent: _progressController, curve: curve));
  }

  Paint _createArcPaint() {
    return Paint()
      ..strokeCap = StrokeCap.round
      ..color = _arcColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = _arcStrokeWidth;
  }

  Paint _createBackgroundPaint() {
    return Paint()..color = _backgroundColor;
  }
}
