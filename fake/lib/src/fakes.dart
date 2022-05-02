import 'package:tdlib/td_api.dart' as td;

td.Message createFakeMessage() {
  return const td.Message(
    canBeSaved: false,
    canGetMediaTimestampLinks: false,
    canGetViewers: false,
    hasTimestampedMedia: false,
    senderId: td.MessageSenderUser(
      userId: 0,
    ),
    chatId: 0,
    isPinned: false,
    date: 0,
    id: 0,
    canBeDeletedForAllUsers: false,
    canBeDeletedOnlyForSelf: false,
    canBeEdited: false,
    canBeForwarded: false,
    canGetMessageThread: false,
    canGetStatistics: false,
    containsUnreadMention: false,
    editDate: 0,
    isChannelPost: false,
    isOutgoing: false,
    mediaAlbumId: 0,
    messageThreadId: 0,
    replyInChatId: 0,
    replyToMessageId: 0,
    restrictionReason: '',
    ttl: 0,
    ttlExpiresIn: 0.0,
    viaBotUserId: 0,
    content: td.MessageText(
      text: td.FormattedText(
        text: 'text',
        entities: <td.TextEntity>[],
      ),
    ),
  );
}

td.Chat createFakeChat({
  int? id,
  List<td.ChatPosition>? positions,
}) {
  return td.Chat(
    hasProtectedContent: false,
    messageTtl: 0,
    themeName: '',
    videoChat: const td.VideoChat(
      groupCallId: 0,
      hasParticipants: false,
    ),
    id: id ?? 0,
    title: 'title',
    canBeReported: false,
    clientData: '',
    defaultDisableNotification: false,
    hasScheduledMessages: false,
    isBlocked: false,
    isMarkedAsUnread: false,
    lastReadInboxMessageId: 0,
    lastReadOutboxMessageId: 0,
    replyMarkupMessageId: 0,
    type: const td.ChatTypePrivate(
      userId: 0,
    ),
    permissions: const td.ChatPermissions(
      canAddWebPagePreviews: false,
      canChangeInfo: false,
      canInviteUsers: false,
      canPinMessages: false,
      canSendMediaMessages: false,
      canSendMessages: false,
      canSendOtherMessages: false,
      canSendPolls: false,
    ),
    positions: positions ?? <td.ChatPosition>[],
    unreadCount: 0,
    unreadMentionCount: 0,
    notificationSettings: const td.ChatNotificationSettings(
      muteFor: 0,
      disableMentionNotifications: false,
      disablePinnedMessageNotifications: false,
      showPreview: false,
      sound: '',
      useDefaultDisableMentionNotifications: false,
      useDefaultDisablePinnedMessageNotifications: false,
      useDefaultMuteFor: false,
      useDefaultShowPreview: false,
      useDefaultSound: false,
    ),
    canBeDeletedForAllUsers: false,
    canBeDeletedOnlyForSelf: false,
  );
}
