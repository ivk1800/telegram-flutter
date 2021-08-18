import 'package:tdlib/td_api.dart' as td;

import 'background_fill.dart';
import 'color_rgb24_ext.dart';

extension BackgroundFillExt on td.BackgroundFill {
  IBackgroundFill toBackgroundFill() {
    final td.BackgroundFill fill = this;
    if (fill is td.BackgroundFillSolid) {
      return BackgroundFillSolid(
        color: fill.color.toColor(),
      );
    } else if (fill is td.BackgroundFillGradient) {
      return BackgroundFillGradient(
        topColor: fill.topColor.toColor(),
        bottomColor: fill.bottomColor.toColor(),
        angle: fill.rotationAngle,
      );
    }

    throw StateError('unexpected background $runtimeType');
  }
}
