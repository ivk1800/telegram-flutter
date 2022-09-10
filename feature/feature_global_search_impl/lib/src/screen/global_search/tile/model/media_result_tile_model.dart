import 'package:core_presentation/core_presentation.dart';
import 'package:flutter/rendering.dart';
import 'package:tile/tile.dart';

class MediaResultTileModel implements ITileModel {
  const MediaResultTileModel({
    required this.title,
    required this.chatId,
    required this.subtitle,
    required this.avatar,
  });

  final int chatId;
  final Avatar avatar;
  // todo replace by RichText
  final InlineSpan title;
  final InlineSpan subtitle;
}
