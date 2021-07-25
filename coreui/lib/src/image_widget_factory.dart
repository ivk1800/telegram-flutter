import 'dart:typed_data';
import 'dart:ui';

import 'package:core_tdlib_api/core_tdlib_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ImageWidgetFactory {
  ImageWidgetFactory({required IFileRepository fileRepository})
      : _fileRepository = fileRepository;

  final IFileRepository _fileRepository;

  Widget create(BuildContext context,
      {Uint8List? minithumbnail, int? imageId}) {
    if (minithumbnail == null) {
      return Container(color: Colors.red);
    }

    return ClipRect(
      child: ImageFiltered(
          imageFilter: ImageFilter.blur(sigmaY: 5, sigmaX: 5),
          child: Image.memory(
            minithumbnail,
            fit: BoxFit.fill,
          )),
    );
  }
}
