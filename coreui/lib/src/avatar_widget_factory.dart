import 'dart:io';

import 'package:core_tdlib_api/core_tdlib_api.dart';
import 'package:flutter/material.dart';
import 'package:jugger/jugger.dart' as j;
import 'package:tdlib/td_api.dart' as td;

class AvatarWidgetFactory {
  @j.inject
  AvatarWidgetFactory({required IFileRepository fileRepository})
      : _fileRepository = fileRepository;

  final IFileRepository _fileRepository;

  // todo move to core ui module
  /// https://github.com/DrKLO/Telegram/blob/ca13bc972dda0498b8ffb40276423a49325cd26d/TMessagesProj/src/main/java/org/telegram/ui/ActionBar/Theme.java#L119
  static const List<Color> colors = <Color>[
    Color(0xffe56555),
    Color(0xfff28c48),
    Color(0xff8e85ee),
    Color(0xff76c84d),
    Color(0xff5fbed5),
    Color(0xff549cdd),
    Color(0xfff2749a),
  ];

  // todo rename chatId to some another name
  Widget create(
    BuildContext context, {
    double radius = 20,
    int? imageId,
    required int chatId,
  }) {
    if (imageId == null) {
      return _DefaultAvatar(radius: radius, chatId: chatId);
    }

    return FutureBuilder<td.LocalFile>(
      future: _fileRepository.getLocalFile(imageId),
      builder: (BuildContext context, AsyncSnapshot<td.LocalFile> snapshot) {
        final String? path = _fileRepository.getPathOrNull(imageId);

        if (path == null) {
          return _DefaultAvatar(radius: radius, chatId: chatId);
        }

        return CircleAvatar(
          maxRadius: radius,
          backgroundImage: FileImage(File(path)),
        );
      },
    );
  }
}

class _DefaultAvatar extends StatelessWidget {
  const _DefaultAvatar({
    Key? key,
    required this.radius,
    required this.chatId,
  }) : super(key: key);

  final double radius;
  final int chatId;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: AvatarWidgetFactory
          .colors[(chatId % AvatarWidgetFactory.colors.length).abs()],
      maxRadius: radius,
    );
  }
}
