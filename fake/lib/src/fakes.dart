import 'package:td_api/td_api.dart' as td;

td.Message createFakeMessage() {
  return const td.Message(
    autoDeleteIn: 0,
    selfDestructIn: 0,
    selfDestructTime: 0,
    unreadReactions: <td.UnreadReaction>[],
    canGetAddedReactions: false,
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
    viaBotUserId: 0,
    content: td.MessageText(
      text: td.FormattedText(
        text: 'text',
        entities: <td.TextEntity>[],
      ),
    ),
    canReportReactions: false,
    isTopicMessage: false,
  );
}

td.Chat createFakeChat({
  int? id,
  List<td.ChatPosition>? positions,
}) {
  return td.Chat(
    isTranslatable: false,
    messageAutoDeleteTime: 0,
    unreadReactionCount: 0,
    availableReactions: const td.ChatAvailableReactionsAll(),
    hasProtectedContent: false,
    themeName: '',
    videoChat: const td.VideoChat(
      groupCallId: 0,
      hasParticipants: false,
    ),
    id: id ?? 0,
    title: 'Title Name',
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
      canSendAudios: false,
      canSendBasicMessages: false,
      canSendDocuments: false,
      canSendPhotos: false,
      canSendVideoNotes: false,
      canSendVideos: false,
      canSendVoiceNotes: false,
      canAddWebPagePreviews: false,
      canChangeInfo: false,
      canInviteUsers: false,
      canPinMessages: false,
      canSendOtherMessages: false,
      canSendPolls: false,
      canManageTopics: false,
    ),
    positions: positions ?? <td.ChatPosition>[],
    unreadCount: 0,
    unreadMentionCount: 0,
    notificationSettings: const td.ChatNotificationSettings(
      muteFor: 0,
      disableMentionNotifications: false,
      disablePinnedMessageNotifications: false,
      showPreview: false,
      soundId: 0,
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

td.Background createBackground() {
  return td.Background(
    id: 0,
    isDark: false,
    isDefault: false,
    name: '',
    type: const td.BackgroundTypeFill(
      fill: td.BackgroundFillSolid(
        color: 0,
      ),
    ),
    document: createDocument(),
  );
}

td.Document createDocument() {
  return const td.Document(
    fileName: '',
    mimeType: '',
    document: td.File(
      id: 0,
      size: 0,
      expectedSize: 0,
      local: td.LocalFile(
        canBeDeleted: false,
        canBeDownloaded: false,
        downloadedPrefixSize: 0,
        downloadedSize: 0,
        downloadOffset: 0,
        isDownloadingActive: false,
        isDownloadingCompleted: false,
        path: '',
      ),
      remote: td.RemoteFile(
        id: '',
        isUploadingActive: false,
        isUploadingCompleted: false,
        uniqueId: '',
        uploadedSize: 0,
      ),
    ),
  );
}
