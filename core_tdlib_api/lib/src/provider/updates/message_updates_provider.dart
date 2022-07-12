import 'package:td_api/td_api.dart' as td;

/// updates for messages list
abstract class IChatMessagesUpdatesProvider {
  Stream<td.Update> get chatMessageUpdates;
}

extension ChatMessageUpdatesExtensions on td.Update {
  void whenChatMessageUpdates<TResult extends Object?>({
    required void Function(td.UpdateMessageContent value) content,
    required void Function(td.UpdateMessageContentOpened value) contentOpened,
    required void Function(td.UpdateMessageEdited value) edited,
    required void Function(td.UpdateMessageInteractionInfo value)
        interactionInfo,
    required void Function(td.UpdateMessageIsPinned value) isPinned,
    required void Function(td.UpdateMessageLiveLocationViewed value)
        liveLocationViewed,
    required void Function(td.UpdateMessageMentionRead value) mentionRead,
    required void Function(td.UpdateMessageSendAcknowledged value)
        sendAcknowledged,
    // required void Function(td.UpdateMessageSendFailed value) sendFailed,
    // required void Function(td.UpdateMessageSendSucceeded value) sendSucceeded,
    required void Function(td.UpdateNewMessage value) newMessage,
    required void Function(td.UpdateDeleteMessages value) updateDeleteMessages,
  }) {
    switch (getConstructor()) {
      case td.UpdateMessageContent.constructor:
        content.call(this as td.UpdateMessageContent);
        break;
      case td.UpdateMessageContentOpened.constructor:
        contentOpened.call(this as td.UpdateMessageContentOpened);
        break;
      case td.UpdateMessageEdited.constructor:
        edited.call(this as td.UpdateMessageEdited);
        break;
      case td.UpdateMessageInteractionInfo.constructor:
        interactionInfo.call(this as td.UpdateMessageInteractionInfo);
        break;
      case td.UpdateMessageIsPinned.constructor:
        isPinned.call(this as td.UpdateMessageIsPinned);
        break;
      case td.UpdateMessageLiveLocationViewed.constructor:
        liveLocationViewed.call(this as td.UpdateMessageLiveLocationViewed);
        break;
      case td.UpdateMessageMentionRead.constructor:
        mentionRead.call(this as td.UpdateMessageMentionRead);
        break;
      case td.UpdateMessageSendAcknowledged.constructor:
        sendAcknowledged.call(this as td.UpdateMessageSendAcknowledged);
        break;
      // case td.UpdateMessageSendFailed.constructor:
      //   sendFailed.call(this as td.UpdateMessageSendFailed);
      //   break;
      // case td.UpdateMessageSendSucceeded.constructor:
      //   sendSucceeded.call(this as td.UpdateMessageSendSucceeded);
      //   break;
      case td.UpdateNewMessage.constructor:
        newMessage.call(this as td.UpdateNewMessage);
        break;
      case td.UpdateDeleteMessages.constructor:
        updateDeleteMessages.call(this as td.UpdateDeleteMessages);
        break;
    }
  }
}
