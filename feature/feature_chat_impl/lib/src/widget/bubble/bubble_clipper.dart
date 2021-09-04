import 'dart:ui';

import 'package:flutter/rendering.dart';

class BubbleClipper extends CustomClipper<Path> {
  BubbleClipper({required this.radius});

  final double radius;

  @override
  Path getClip(Size size) {
    const double rightPadding = 0;
    const double leftPadding = 0;

    final Path path = Path()
      // start top left
      ..lineTo(leftPadding, radius)
      ..arcToPoint(
        Offset(leftPadding + radius, 0),
        radius: Radius.circular(radius),
      )
      // end top left

      // start top right
      ..lineTo(size.width - radius - rightPadding, 0)
      ..arcToPoint(
        Offset(size.width - rightPadding, radius),
        radius: Radius.circular(radius),
      )
      // end top right

      // start bottom right
      ..lineTo(size.width - rightPadding, size.height - radius)
      ..arcToPoint(
        Offset(size.width - rightPadding - radius, size.height),
        radius: Radius.circular(radius),
      )

      // end bottom right

      // start bottom left
      ..lineTo(radius + leftPadding, size.height)
      ..arcToPoint(
        Offset(leftPadding, size.height - radius),
        radius: Radius.circular(radius),
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
