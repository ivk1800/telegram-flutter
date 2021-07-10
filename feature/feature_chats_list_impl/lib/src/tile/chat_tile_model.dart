class ChatTileModel {
  ChatTileModel({
    this.photoId,
    required this.id,
    required this.unreadMessagesCount,
    required this.isPinned,
    required this.isVerified,
    required this.isMuted,
    required this.isMentioned,
    required this.lastMessageDate,
    required this.title,
    required this.firstSubtitle,
    required this.secondSubtitle,
  });

  final bool isPinned;
  final int id;
  final String? lastMessageDate;
  final int unreadMessagesCount;
  final int? photoId;
  final bool isVerified;
  final bool isMuted;
  final bool isMentioned;
  final String title;
  final String? firstSubtitle;
  final String? secondSubtitle;
}

extension ChatTileModelExtension on ChatTileModel {
  ChatTileModel copy(
          {bool? isPinned,
          int? id,
          int? unreadMessagesCount,
          String? lastMessageDate,
          int? photoId,
          bool? isVerified,
          bool? isMentioned,
          bool? isMuted,
          String? title,
          String? firstSubtitle,
          String? secondSubtitle}) =>
      ChatTileModel(
        isPinned: isPinned ?? this.isPinned,
        id: id ?? this.id,
        isMuted: isMuted ?? this.isMuted,
        isMentioned: isMentioned ?? this.isMentioned,
        isVerified: isVerified ?? this.isVerified,
        unreadMessagesCount: unreadMessagesCount ?? this.unreadMessagesCount,
        firstSubtitle: firstSubtitle ?? this.firstSubtitle,
        secondSubtitle: secondSubtitle ?? this.secondSubtitle,
        lastMessageDate: lastMessageDate ?? this.lastMessageDate,
        title: title ?? this.title,
        photoId: photoId ?? this.photoId,
      );
}
