import 'package:flutter/animation.dart';

class StaticCurve extends Curve {
  const StaticCurve();

  @override
  double transformInternal(double t) => 1;
}
