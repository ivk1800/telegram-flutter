import 'package:feature_chat_impl/src/tile/model/base_conversation_message_tile_model.dart';
import 'package:feature_chat_impl/src/wall/message_wall_context.dart';
import 'package:feature_chat_impl/src/widget/chat_message/sender_avatar_factory.dart';
import 'package:feature_chat_impl/src/widget/widget.dart';
import 'package:flutter/cupertino.dart';

class MessageComponentResolver {
  const MessageComponentResolver({
    required SenderAvatarFactory senderAvatarFactory,
    required IMessageWallContext messageWallContext,
    required SenderTitleFactory senderTitleFactory,
  })  : _senderAvatarFactory = senderAvatarFactory,
        _messageWallContext = messageWallContext,
        _senderTitleFactory = senderTitleFactory;

  final SenderAvatarFactory _senderAvatarFactory;
  final IMessageWallContext _messageWallContext;
  final SenderTitleFactory _senderTitleFactory;

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
    return _messageWallContext.isDisplayAvatarFor(model.id)
        ? _senderAvatarFactory.create(context, model.senderInfo)
        : const Padding(
            padding: EdgeInsets.only(right: 8),
            child: SizedBox(
              width: 40,
              height: 40,
            ),
          );
  }
}
