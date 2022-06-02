import 'package:feature_chat_impl/feature_chat_impl.dart';
import 'package:feature_chat_impl/src/resolver/message_component_resolver.dart';
import 'package:feature_chat_impl/src/widget/widget.dart';
import 'package:flutter/material.dart';
import 'package:tile/tile.dart';

class MessageTextTileFactoryDelegate
    implements ITileFactoryDelegate<MessageTextTileModel> {
  MessageTextTileFactoryDelegate({
    required MessageComponentResolver messageComponentResolver,
    required ChatMessageFactory chatMessageFactory,
    required ShortInfoFactory shortInfoFactory,
    required ReplyInfoFactory replyInfoFactory,
  })  : _chatMessageFactory = chatMessageFactory,
        _messageComponentResolver = messageComponentResolver,
        _shortInfoFactory = shortInfoFactory,
        _replyInfoFactory = replyInfoFactory;

  final ChatMessageFactory _chatMessageFactory;
  final ReplyInfoFactory _replyInfoFactory;
  final ShortInfoFactory _shortInfoFactory;
  final MessageComponentResolver _messageComponentResolver;

  @override
  Widget create(BuildContext context, MessageTextTileModel model) {
    final ChatContextData chatContextData = ChatContext.of(context);
    return _chatMessageFactory.createConversationMessage(
      id: model.id,
      isOutgoing: model.isOutgoing,
      context: context,
      senderTitle:
          _messageComponentResolver.resolveSenderName(context, model) ??
              // todo extract ext
              SizedBox(height: chatContextData.verticalPadding),
      reply: _replyInfoFactory.createFromMessageModel(context, model),
      blocks: <Widget>[
        MessageCaption(
          text: model.text,
          shortInfo: _shortInfoFactory.create(
            context: context,
            additionalInfo: model.additionalInfo,
            isOutgoing: model.isOutgoing,
            padding: EdgeInsets.only(bottom: chatContextData.verticalPadding),
          ),
        ),
      ],
    );
  }
}
