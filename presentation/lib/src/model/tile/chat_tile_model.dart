import 'package:flutter/painting.dart';
import 'package:tdlib/td_api.dart' as td;

class ChatTileModel {
  ChatTileModel(
      {this.photoId,
      required this.chat,
      required this.id,
      required this.lastMessageDate,
      required this.title,
      required this.subtitle});

  final td.Chat chat;
  final int id;
  final String? lastMessageDate;
  final int? photoId;
  final InlineSpan title;
  final InlineSpan subtitle;
}
