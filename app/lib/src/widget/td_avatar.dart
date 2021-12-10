import 'dart:io';

import 'package:app/src/widget/widget.dart';
import 'package:flutter/material.dart';
import 'package:tdlib/td_api.dart' as td;

class TdAvatar extends StatelessWidget {
  const TdAvatar({Key? key, this.image}) : super(key: key);

  final td.File? image;

  @override
  Widget build(BuildContext context) {
    final String? filePath = image?.local.path;

    if (image != null) {
      TdImageLoader.of(context).load(image!);
    }

    return CircleAvatar(
      backgroundImage: filePath != null && filePath.isNotEmpty
          ? FileImage(File(filePath))
          : null,
    );
  }
}
