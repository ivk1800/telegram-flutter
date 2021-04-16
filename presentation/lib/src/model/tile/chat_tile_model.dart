import 'package:flutter/painting.dart';
import 'package:tdlib/td_api.dart' as td;

class ChatTileModel {
  ChatTileModel(
      {this.photoId,
      required this.id,
      required this.unreadMessagesCount,
      required this.isPinned,
      required this.lastMessageDate,
      required this.title,
      required this.subtitle});

  final bool isPinned;
  final int id;
  final String? lastMessageDate;
  final int unreadMessagesCount;
  final int? photoId;
  final InlineSpan title;
  final InlineSpan subtitle;
}

extension ChatTileModelExtension on ChatTileModel {
  ChatTileModel copy({
    bool? isPinned,
    int? id,
    int? unreadMessagesCount,
    String? lastMessageDate,
    int? photoId,
    InlineSpan? title,
    InlineSpan? subtitle,
  }) =>
      ChatTileModel(
        isPinned: isPinned ?? this.isPinned,
        id: id ?? this.id,
        unreadMessagesCount: unreadMessagesCount ?? this.unreadMessagesCount,
        subtitle: subtitle ?? this.subtitle,
        lastMessageDate: lastMessageDate ?? this.lastMessageDate,
        title: title ?? this.title,
        photoId: photoId ?? this.photoId,
      );
}
