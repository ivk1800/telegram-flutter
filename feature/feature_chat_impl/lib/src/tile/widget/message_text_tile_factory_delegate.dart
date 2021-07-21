import 'package:coreui/coreui.dart';
import 'package:feature_chat_impl/src/tile/model/tile_model.dart';
import 'package:feature_chat_impl/src/widget/chat_message/chat_message_factory.dart';
import 'package:feature_chat_impl/src/widget/chat_message/reply_info_factory.dart';
import 'package:feature_chat_impl/src/widget/message_composite_text.dart';
import 'package:flutter/material.dart';

class MessageTextTileFactoryDelegate
    implements ITileFactoryDelegate<MessageTextTileModel> {
  MessageTextTileFactoryDelegate({
    required ChatMessageFactory chatMessageFactory,
    required ReplyInfoFactory replyInfoFactory,
  })  : _chatMessageFactory = chatMessageFactory,
        _replyInfoFactory = replyInfoFactory;

  final ChatMessageFactory _chatMessageFactory;
  final ReplyInfoFactory _replyInfoFactory;

  @override
  Widget create(BuildContext context, MessageTextTileModel model) {
    return _chatMessageFactory.createConversationMessage(
        id: model.id,
        isOutgoing: model.isOutgoing,
        context: context,
        reply: _replyInfoFactory.createFromMessageModel(context, model),
        blocks: <Widget>[
          MessageCaption(
            text: model.text,
            shortInfo: Text(
              '22:46',
              style: Theme.of(context).textTheme.caption,
            ),
          ),
        ]);
  }
}
