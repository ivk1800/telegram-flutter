import 'package:meta/meta.dart';

@immutable
class Size {
  const Size({
    required this.width,
    required this.height,
  });

  final double width;
  final double height;
}
