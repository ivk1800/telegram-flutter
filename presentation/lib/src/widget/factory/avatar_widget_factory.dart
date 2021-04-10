import 'dart:io';

import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:tdlib/td_api.dart' as td;
import 'package:jugger/jugger.dart' as j;

class AvatarWidgetFactory {
  @j.inject
  AvatarWidgetFactory(this._fileRepository);

  final IFileRepository _fileRepository;

  Widget create(BuildContext context, int? imageId) {
    if (imageId == null) {
      return const CircleAvatar(maxRadius: _AvatarRadius);
    }

    return FutureBuilder<td.LocalFile>(
      future: _fileRepository.getLocalFile(imageId),
      builder: (BuildContext context, AsyncSnapshot<td.LocalFile> snapshot) {
        final String? path = snapshot.data?.path;

        if (path == null) {
          return const CircleAvatar(
            maxRadius: _AvatarRadius,
          );
        }

        return CircleAvatar(
            maxRadius: _AvatarRadius, backgroundImage: FileImage(File(path)));
      },
    );
  }

  static const double _AvatarRadius = 30;
}
