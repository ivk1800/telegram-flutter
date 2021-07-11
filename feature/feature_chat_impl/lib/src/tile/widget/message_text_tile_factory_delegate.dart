import 'package:coreui/coreui.dart';
import 'package:feature_chat_impl/src/tile/model/tile_model.dart';
import 'package:feature_chat_impl/src/widget/chat_message/chat_message_factory.dart';
import 'package:feature_chat_impl/src/widget/message_composite_text.dart';
import 'package:feature_chat_impl/src/widget/theme/chat_theme.dart';
import 'package:flutter/material.dart';

class MessageTextTileFactoryDelegate
    implements ITileFactoryDelegate<MessageTextTileModel> {
  MessageTextTileFactoryDelegate(
      {required ChatMessageFactory chatMessageFactory})
      : _chatMessageFactory = chatMessageFactory;

  final ChatMessageFactory _chatMessageFactory;

  @override
  Widget create(BuildContext context, MessageTextTileModel model) {
    return _chatMessageFactory.createFromBlocks(
        id: model.id,
        context: context,
        isOutgoing: model.isOutgoing,
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
