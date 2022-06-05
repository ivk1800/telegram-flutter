import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:lottie/lottie.dart';

class Sticker extends StatelessWidget {
  const Sticker({
    super.key,
    required this.file,
  });

  final File file;

  @override
  Widget build(BuildContext context) => Lottie.file(file);
}
