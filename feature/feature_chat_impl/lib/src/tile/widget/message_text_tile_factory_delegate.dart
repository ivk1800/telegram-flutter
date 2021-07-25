import 'package:coreui/coreui.dart';
import 'package:feature_chat_impl/src/resolver/message_component_resolver.dart';
import 'package:feature_chat_impl/src/tile/model/tile_model.dart';
import 'package:feature_chat_impl/src/widget/widget.dart';
import 'package:flutter/material.dart';

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
    return _chatMessageFactory.createConversationMessage(
        id: model.id,
        isOutgoing: model.isOutgoing,
        context: context,
        senderTitle:
            _messageComponentResolver.resolveSenderName(context, model),
        reply: _replyInfoFactory.createFromMessageModel(context, model),
        avatar: _messageComponentResolver.resolveAvatar(context, model),
        blocks: <Widget>[
          MessageCaption(
            text: model.text,
            shortInfo: _shortInfoFactory.create(context, model.additionalInfo),
          ),
        ]);
  }
}
