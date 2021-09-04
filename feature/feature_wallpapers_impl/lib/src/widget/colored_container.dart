import 'package:feature_wallpapers_impl/src/util/background_fill.dart';
import 'package:flutter/widgets.dart';

class ColoredContainer extends StatelessWidget {
  const ColoredContainer({
    Key? key,
    required this.fill,
    this.child,
  }) : super(key: key);

  final IBackgroundFill fill;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    final IBackgroundFill fill = this.fill;
    if (fill is BackgroundFillSolid) {
      return Container(
        color: fill.color,
        child: child,
      );
    } else if (fill is BackgroundFillGradient) {
      return Container(
        child: child,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              fill.topColor,
              fill.bottomColor,
            ],
          ),
        ),
      );
    }
    throw StateError('unexpected fill type ${fill.runtimeType}');
  }
}
