import 'package:feature_chat_impl/feature_chat_impl.dart';
import 'package:feature_chat_impl/src/tile/model/base_conversation_message_tile_model.dart';
import 'package:feature_chat_impl/src/widget/chat_message/sender_avatar_factory.dart';
import 'package:feature_chat_impl/src/widget/widget.dart';
import 'package:flutter/cupertino.dart';

class MessageComponentResolver {
  const MessageComponentResolver({
    required SenderAvatarFactory senderAvatarFactory,
    required IMessageWallContext messageWallContext,
    required SenderTitleFactory senderTitleFactory,
    required IMessageActionListener messageActionListener,
  })  : _senderAvatarFactory = senderAvatarFactory,
        _messageWallContext = messageWallContext,
        _messageActionListener = messageActionListener,
        _senderTitleFactory = senderTitleFactory;

  final SenderAvatarFactory _senderAvatarFactory;
  final IMessageWallContext _messageWallContext;
  final SenderTitleFactory _senderTitleFactory;
  final IMessageActionListener _messageActionListener;

  Widget? resolveSenderName(
    BuildContext context,
    BaseConversationMessageTileModel model,
  ) {
    return _messageWallContext.isDisplaySenderNameFor(model.id)
        ? _senderTitleFactory.createFromMessageModel(context, model)
        : null;
  }

  Widget? resolveAvatar(
    BuildContext context,
    BaseConversationMessageTileModel model,
  ) {
    if (model.isOutgoing) {
      return null;
    }

    if (_messageWallContext.isDisplayAvatarFor(model.id)) {
      return _senderAvatarFactory.create(
        context: context,
        senderInfo: model.senderInfo,
        onTap: () => _messageActionListener.onSenderAvatarTap(
          senderId: model.senderInfo.id,
        ),
      );
    } else {
      // todo copy paste from senderAvatarFactory
      return const Padding(
        padding: EdgeInsets.only(right: 8),
        child: SizedBox(
          width: 40,
          height: 40,
        ),
      );
    }
  }
}
