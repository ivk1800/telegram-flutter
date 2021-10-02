import 'package:flutter/rendering.dart';
import 'package:tile/tile.dart';

class MediaResultTileModel implements ITileModel {
  const MediaResultTileModel({
    required this.title,
    required this.chatId,
    required this.subtitle,
    required this.avatarId,
  });

  final int chatId;
  final int? avatarId;
  // todo replace by RichText
  final InlineSpan title;
  final InlineSpan subtitle;
}
