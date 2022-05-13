import 'package:flutter/material.dart';

class ContainerDivider extends StatelessWidget {
  const ContainerDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _DividerPainter(),
    );
  }
}

class _DividerPainter extends CustomPainter {
  final Paint _paint = Paint()
    ..color = Colors.grey
    ..strokeWidth = 1
    ..strokeCap = StrokeCap.round;

  @override
  void paint(Canvas canvas, Size size) {
    final Offset startingPoint = Offset(size.width / 2, 0);
    final Offset endingPoint = Offset(size.width / 2, size.height);

    canvas.drawLine(startingPoint, endingPoint, _paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
