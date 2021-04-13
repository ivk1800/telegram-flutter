import 'package:flutter/painting.dart';
import 'package:tdlib/td_api.dart' as td;

class ChatTileModel {
  ChatTileModel(
      {this.photoId,
      required this.id,
      required this.isPinned,
      required this.lastMessageDate,
      required this.title,
      required this.subtitle});

  final bool isPinned;
  final int id;
  final String? lastMessageDate;
  final int? photoId;
  final InlineSpan title;
  final InlineSpan subtitle;
}

extension ChatTileModelExtension on ChatTileModel {
  ChatTileModel copy({
    bool? isPinned,
    int? id,
    String? lastMessageDate,
    int? photoId,
    InlineSpan? title,
    InlineSpan? subtitle,
  }) =>
      ChatTileModel(
        isPinned: isPinned ?? this.isPinned,
        id: id ?? this.id,
        subtitle: subtitle ?? this.subtitle,
        lastMessageDate: lastMessageDate ?? this.lastMessageDate,
        title: title ?? this.title,
        photoId: photoId ?? this.photoId,
      );
}
