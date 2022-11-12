import 'dart:ui';

import 'package:flutter/widgets.dart';
import 'package:shared_models/shared_models.dart' as shm;

class Minithumbnail extends StatelessWidget {
  const Minithumbnail({
    super.key,
    required this.minithumbnail,
  });

  final shm.Minithumbnail minithumbnail;

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
