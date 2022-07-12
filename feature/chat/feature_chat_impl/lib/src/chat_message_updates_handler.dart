import 'dart:async';

import 'package:core_tdlib_api/core_tdlib_api.dart';
import 'package:feature_chat_impl/feature_chat_impl.dart';
import 'package:feature_chat_impl/src/tile/model/base_message_tile_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:queue/queue.dart';
import 'package:td_api/td_api.dart' as td;
import 'package:tile/tile.dart';

/// Return copy of actual messages.
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
    update.whenChatMessageUpdates(
      content: (td.UpdateMessageContent value) {},
      contentOpened: (td.UpdateMessageContentOpened value) {},
      edited: (td.UpdateMessageEdited value) {},
      interactionInfo: (td.UpdateMessageInteractionInfo value) {},
      isPinned: (td.UpdateMessageIsPinned value) {},
      liveLocationViewed: (td.UpdateMessageLiveLocationViewed value) {},
      mentionRead: (td.UpdateMessageMentionRead value) {},
      sendAcknowledged: (td.UpdateMessageSendAcknowledged value) {},
      newMessage: (td.UpdateNewMessage value) {
        if (_isThisChat(value.message.chatId)) {
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
      updateDeleteMessages: (td.UpdateDeleteMessages value) {
        if (value.fromCache || !_isThisChat(value.chatId)) {
          return;
        }

        _updatesQueue.enqueue(() async {
          _runIfAttached((
            UpdatedMessages updatedMessagesCallback,
            List<ITileModel> actualMessages,
          ) async {
            final List<ITileModel> newList = actualMessages
              ..removeWhere(
                (ITileModel element) =>
                    element is BaseMessageTileModel &&
                    value.messageIds.contains(element.id),
              );
            updatedMessagesCallback.call(newList);
          });
        });
      },
    );
  }

  bool _isThisChat(int chatId) => _chatId == chatId;

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
