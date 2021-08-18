import 'dart:ui';

abstract class IBackgroundFill {
  const IBackgroundFill();
}

class BackgroundFillSolid implements IBackgroundFill {
  const BackgroundFillSolid({required this.color});

  final Color color;
}

class BackgroundFillGradient implements IBackgroundFill {
  const BackgroundFillGradient({
    required this.topColor,
    required this.bottomColor,
    required this.angle,
  });

  final Color topColor;
  final Color bottomColor;
  final int angle;
}
