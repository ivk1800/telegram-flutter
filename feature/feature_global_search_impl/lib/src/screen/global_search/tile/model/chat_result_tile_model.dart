import 'package:flutter/painting.dart';
import 'package:shared_models/shared_models.dart';
import 'package:tile/tile.dart';

class ChatResultTileModel implements ITileModel {
  const ChatResultTileModel({
    required this.title,
    required this.chatId,
    required this.subtitle,
    required this.avatar,
  });

  final int chatId;
  final Avatar avatar;
  // todo use RichText
  final InlineSpan title;
  final InlineSpan subtitle;
}
