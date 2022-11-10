import 'package:emoji_ui_kit/emoji_ui_kit.dart';
import 'package:feature_chat_impl/src/tile/model/tile_model.dart';
import 'package:feature_chat_impl/src/widget/chat_context.dart';
import 'package:feature_chat_impl/src/widget/chat_message/chat_message_factory.dart';
import 'package:feature_chat_impl/src/widget/chat_message/short_info_factory.dart';
import 'package:flutter/material.dart';
import 'package:tile/tile.dart';

class MessageAnimatedEmojiTileFactoryDelegate
    implements ITileFactoryDelegate<MessageAnimatedEmojiTileModel> {
  MessageAnimatedEmojiTileFactoryDelegate({
    required ChatMessageFactory chatMessageFactory,
    required CustomEmojiWidgetFactory customEmojiWidgetFactory,
    required ShortInfoFactory shortInfoFactory,
  })  : _chatMessageFactory = chatMessageFactory,
        _shortInfoFactory = shortInfoFactory,
        _customEmojiWidgetFactory = customEmojiWidgetFactory;

  final ChatMessageFactory _chatMessageFactory;
  final CustomEmojiWidgetFactory _customEmojiWidgetFactory;
  final ShortInfoFactory _shortInfoFactory;

  @override
  Widget create(
    BuildContext context,
    MessageAnimatedEmojiTileModel model,
  ) {
    final ChatContextData chatContextData = ChatContext.of(context);
    return _chatMessageFactory.createConversationMessage(
      context: context,
      isOutgoing: model.isOutgoing,
      blocks: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 4),
          child: _customEmojiWidgetFactory.create(
            context,
            customEmojiId: model.customEmojiId,
          ),
        ),
        _shortInfoFactory.create(
          context: context,
          additionalInfo: model.additionalInfo,
          isOutgoing: model.isOutgoing,
          padding: EdgeInsets.symmetric(
            vertical: chatContextData.verticalPadding,
            horizontal: chatContextData.horizontalPadding,
          ),
        )
      ],
      reply: null,
      senderTitle: null,
    );
  }
}
