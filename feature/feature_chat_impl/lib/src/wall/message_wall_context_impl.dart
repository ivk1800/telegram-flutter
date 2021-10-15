import 'package:feature_chat_impl/src/interactor/chat_messages_list_interactor.dart';

import 'message_wall_context.dart';

// todo refactor and optimize
class MessageWallContextImpl implements IMessageWallContext {
  const MessageWallContextImpl({
    required ChatMessagesInteractor chatMessagesInteractor,
  }) : _chatMessagesInteractor = chatMessagesInteractor;

  final ChatMessagesInteractor _chatMessagesInteractor;

  @override
  bool isDisplayAvatarFor(int messageId) {
    return true;
    /*
    final int index = _chatMessagesInteractor.messages.indexWhere(
      (ITileModel element) =>
          element is BaseConversationMessageTileModel &&
          element.id == messageId,
    );

    if (index == -1) {
      return false;
    }

    final BaseConversationMessageTileModel messageModel =
        _chatMessagesInteractor.messages[index]
            as BaseConversationMessageTileModel;

    if (index == 0) {
      return true;
    }

    final ITileModel prevModel = _chatMessagesInteractor.messages[index - 1];

    if (prevModel is BaseConversationMessageTileModel) {
      return prevModel.senderInfo.id != messageModel.senderInfo.id;
    }

    return false;
 */
  }

  @override
  bool isDisplaySenderNameFor(int messageId) {
    // todo implement
    return true;
  }
}
