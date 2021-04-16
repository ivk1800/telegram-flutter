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

  /// https://github.com/DrKLO/Telegram/blob/ca13bc972dda0498b8ffb40276423a49325cd26d/TMessagesProj/src/main/java/org/telegram/ui/ActionBar/Theme.java#L119
  List<Color> colors = <Color>[
    const Color(0xffe56555),
    const Color(0xfff28c48),
    const Color(0xff8e85ee),
    const Color(0xff76c84d),
    const Color(0xff5fbed5),
    const Color(0xff549cdd),
    const Color(0xfff2749a),
  ];

  Widget create(BuildContext context,
      {required double radius, required int chatId, int? imageId}) {
    if (imageId == null) {
      return _createDefaultAvatar(radius: radius, chatId: chatId);
    }

    return FutureBuilder<td.LocalFile>(
      future: _fileRepository.getLocalFile(imageId),
      builder: (BuildContext context, AsyncSnapshot<td.LocalFile> snapshot) {
        final String? path = _fileRepository.getPathOrNull(imageId);

        if (path == null) {
          return _createDefaultAvatar(radius: radius, chatId: chatId);
        }

        return CircleAvatar(
            maxRadius: radius, backgroundImage: FileImage(File(path)));
      },
    );
  }

  Widget _createDefaultAvatar({required double radius, required int chatId}) {
    return CircleAvatar(
        backgroundColor: colors[(chatId % colors.length).abs()],
        maxRadius: radius);
  }
}
