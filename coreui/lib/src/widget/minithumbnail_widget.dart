import 'dart:ui';

import 'package:flutter/widgets.dart';
import 'package:shared_models/shared_models.dart';

class MinithumbnailWidget extends StatelessWidget {
  const MinithumbnailWidget({
    super.key,
    required this.minithumbnail,
  });

  final Minithumbnail minithumbnail;

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: ImageFiltered(
        imageFilter: ImageFilter.blur(
          sigmaX: 5,
          sigmaY: 5,
        ),
        child: Image.memory(
          minithumbnail.data!,
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}
