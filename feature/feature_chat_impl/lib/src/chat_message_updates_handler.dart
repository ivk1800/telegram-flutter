import 'dart:async';

import 'package:core_tdlib_api/core_tdlib_api.dart';
import 'package:feature_chat_impl/feature_chat_impl.dart';
import 'package:flutter/cupertino.dart';
import 'package:queue/queue.dart';
import 'package:tdlib/td_api.dart' as td;
import 'package:tile/tile.dart';

typedef ActualMessages = List<ITileModel> Function();
typedef UpdatedMessages = void Function(List<ITileModel> updatedMessages);

class ChatMessageUpdatesHandler {
  ChatMessageUpdatesHandler({
    required MessageTileMapper messageTileMapper,
    required IChatMessagesUpdatesProvider chatMessagesUpdatesProvider,
    required int chatId,
  })  : _chatMessagesUpdatesProvider = chatMessagesUpdatesProvider,
        _updatesQueue = Queue<void>(),
        _messageTileMapper = messageTileMapper,
        _chatId = chatId;

  final MessageTileMapper _messageTileMapper;
  final IChatMessagesUpdatesProvider _chatMessagesUpdatesProvider;
  final int _chatId;

  final Queue<void> _updatesQueue;

  StreamSubscription<dynamic>? _updatesSubscription;

  UpdatedMessages? _updatedMessages;
  ActualMessages? _actualMessages;

  void attach({
    required ActualMessages actualMessages,
    required UpdatedMessages onUpdated,
  }) {
    _updatesSubscription?.cancel();
    _actualMessages = actualMessages;
    _updatedMessages = onUpdated;

    _updatesSubscription =
        _chatMessagesUpdatesProvider.chatMessageUpdates.listen(_handleUpdate);
  }

  void dispose() {
    _updatedMessages = null;
    _actualMessages = null;
    _updatesQueue.dispose();
    _updatesSubscription?.cancel();
  }

  void _handleUpdate(td.Update update) {
    update.when(
      content: (td.UpdateMessageContent value) {},
      contentOpened: (td.UpdateMessageContentOpened value) {},
      edited: (td.UpdateMessageEdited value) {},
      interactionInfo: (td.UpdateMessageInteractionInfo value) {},
      isPinned: (td.UpdateMessageIsPinned value) {},
      liveLocationViewed: (td.UpdateMessageLiveLocationViewed value) {},
      mentionRead: (td.UpdateMessageMentionRead value) {},
      sendAcknowledged: (td.UpdateMessageSendAcknowledged value) {},
      newMessage: (td.UpdateNewMessage value) {
        if (_filterUpdate(value.message.chatId)) {
          _updatesQueue.enqueue(() async {
            _runIfAttached((
              UpdatedMessages updatedMessagesCallback,
              List<ITileModel> actualMessages,
            ) async {
              debugPrint(value.toString());
              final ITileModel newTileModel =
                  await _messageTileMapper.mapToTileModel(value.message);
              updatedMessagesCallback
                  .call(actualMessages..insert(0, newTileModel));
            });
          });
        }
      },
      updateDeleteMessages: (td.UpdateDeleteMessages value) {},
    );
  }

  bool _filterUpdate(int chatId) => _chatId == chatId;

  void _runIfAttached(
    Function(
      UpdatedMessages updatedMessagesCallback,
      List<ITileModel> actualMessages,
    )
        callback,
  ) {
    final UpdatedMessages? updatedMessages = _updatedMessages;
    final ActualMessages? actualMessages = _actualMessages;

    if (updatedMessages != null && actualMessages != null) {
      callback.call(
        updatedMessages,
        actualMessages.call().toList(),
      );
    }
  }
}

extension _MessageUpdateExtensions on td.Update {
  void when<TResult extends Object?>({
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
      case td.UpdateMessageContent.CONSTRUCTOR:
        content.call(this as td.UpdateMessageContent);
        break;
      case td.UpdateMessageContentOpened.CONSTRUCTOR:
        contentOpened.call(this as td.UpdateMessageContentOpened);
        break;
      case td.UpdateMessageEdited.CONSTRUCTOR:
        edited.call(this as td.UpdateMessageEdited);
        break;
      case td.UpdateMessageInteractionInfo.CONSTRUCTOR:
        interactionInfo.call(this as td.UpdateMessageInteractionInfo);
        break;
      case td.UpdateMessageIsPinned.CONSTRUCTOR:
        isPinned.call(this as td.UpdateMessageIsPinned);
        break;
      case td.UpdateMessageLiveLocationViewed.CONSTRUCTOR:
        liveLocationViewed.call(this as td.UpdateMessageLiveLocationViewed);
        break;
      case td.UpdateMessageMentionRead.CONSTRUCTOR:
        mentionRead.call(this as td.UpdateMessageMentionRead);
        break;
      case td.UpdateMessageSendAcknowledged.CONSTRUCTOR:
        sendAcknowledged.call(this as td.UpdateMessageSendAcknowledged);
        break;
      // case td.UpdateMessageSendFailed.CONSTRUCTOR:
      //   sendFailed.call(this as td.UpdateMessageSendFailed);
      //   break;
      // case td.UpdateMessageSendSucceeded.CONSTRUCTOR:
      //   sendSucceeded.call(this as td.UpdateMessageSendSucceeded);
      //   break;
      case td.UpdateNewMessage.CONSTRUCTOR:
        newMessage.call(this as td.UpdateNewMessage);
        break;
      case td.UpdateDeleteMessages.CONSTRUCTOR:
        updateDeleteMessages.call(this as td.UpdateDeleteMessages);
        break;
    }
  }
}
