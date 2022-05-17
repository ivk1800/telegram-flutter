import 'package:flutter/painting.dart';
import 'package:tile/tile.dart';

class ChatResultTileModel implements ITileModel {
  const ChatResultTileModel({
    required this.title,
    required this.chatId,
    required this.subtitle,
    required this.avatarId,
  });

  final int chatId;
  final int? avatarId;
  // todo use RichText
  final InlineSpan title;
  final InlineSpan subtitle;
}
