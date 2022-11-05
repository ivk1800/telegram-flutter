import 'package:core_presentation/core_presentation.dart';
import 'package:tile/tile.dart';

class ChatTileModel implements ITileModel {
  const ChatTileModel({
    required this.id,
    required this.avatar,
    required this.unreadMessagesCount,
    required this.isPinned,
    required this.isVerified,
    required this.isMuted,
    required this.isMentioned,
    required this.isSecret,
    required this.isRead,
    required this.lastMessageDate,
    required this.title,
    required this.firstSubtitle,
    required this.secondSubtitle,
    required this.isForum,
  });

  final bool isPinned;
  final int id;
  final Avatar avatar;
  final String? lastMessageDate;
  final int unreadMessagesCount;
  final bool isVerified;
  final bool isMuted;
  final bool isMentioned;
  final bool isSecret;
  final bool? isRead;
  final String title;
  final String? firstSubtitle;
  final String? secondSubtitle;
  final bool isForum;
}

extension ChatTileModelExtension on ChatTileModel {
  ChatTileModel copy({
    bool? isPinned,
    int? id,
    int? unreadMessagesCount,
    String? lastMessageDate,
    Avatar? avatar,
    bool? isVerified,
    bool? isMentioned,
    bool? isMuted,
    bool? isSecret,
    bool? isRead,
    String? title,
    String? firstSubtitle,
    String? secondSubtitle,
    bool? isForum,
  }) =>
      ChatTileModel(
        isPinned: isPinned ?? this.isPinned,
        id: id ?? this.id,
        isMuted: isMuted ?? this.isMuted,
        isSecret: isSecret ?? this.isSecret,
        isRead: isRead ?? this.isRead,
        isMentioned: isMentioned ?? this.isMentioned,
        isVerified: isVerified ?? this.isVerified,
        unreadMessagesCount: unreadMessagesCount ?? this.unreadMessagesCount,
        firstSubtitle: firstSubtitle ?? this.firstSubtitle,
        secondSubtitle: secondSubtitle ?? this.secondSubtitle,
        lastMessageDate: lastMessageDate ?? this.lastMessageDate,
        title: title ?? this.title,
        avatar: avatar ?? this.avatar,
        isForum: isForum ?? this.isForum,
      );
}
