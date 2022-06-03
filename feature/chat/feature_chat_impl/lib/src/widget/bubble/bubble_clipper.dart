import 'package:flutter/rendering.dart';

class BubbleClipper extends CustomClipper<Path> {
  BubbleClipper({required double radius}) : _radius = radius;

  double get radius => _radius;
  double _radius;

  set radius(double value) {
    if (value == _radius) {
      return;
    }
    _radius = value;
  }

  @override
  Path getClip(Size size) {
    const double rightPadding = 0;
    const double leftPadding = 0;

    final Radius radiusCircular = Radius.circular(radius);
    final Path path = Path()
      ..moveTo(0, radius)

      // start top left
      ..lineTo(leftPadding, radius)
      ..arcToPoint(
        Offset(leftPadding + radius, 0),
        radius: radiusCircular,
      )
      // end top left

      // start top right
      ..lineTo(size.width - radius - rightPadding, 0)
      ..arcToPoint(
        Offset(size.width - rightPadding, radius),
        radius: radiusCircular,
      )
      // end top right

      // start bottom right
      ..lineTo(size.width - rightPadding, size.height - radius)
      ..arcToPoint(
        Offset(size.width - rightPadding - radius, size.height),
        radius: radiusCircular,
      )

      // end bottom right

      // start bottom left
      ..lineTo(radius + leftPadding, size.height)
      ..arcToPoint(
        Offset(leftPadding, size.height - radius),
        radius: radiusCircular,
      )
      // end bottom left

      ..lineTo(leftPadding, radius)
      ..close();

    return path;
  }

  @override
  bool shouldReclip(covariant BubbleClipper oldClipper) {
    return oldClipper.radius != radius;
  }
}
