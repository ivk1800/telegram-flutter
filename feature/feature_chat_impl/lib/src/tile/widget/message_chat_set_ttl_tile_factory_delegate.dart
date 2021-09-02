import 'package:feature_chat_impl/src/tile/model/tile_model.dart';
import 'package:feature_chat_impl/src/widget/chat_message/chat_message_factory.dart';
import 'package:flutter/material.dart';
import 'package:rich_text_format_flutter/rich_text_format_flutter.dart';
import 'package:tile/tile.dart';

class MessageChatSetTtlTileFactoryDelegate
    implements ITileFactoryDelegate<MessageChatSetTtlTileModel> {
  MessageChatSetTtlTileFactoryDelegate(
      {required ChatMessageFactory chatMessageFactory})
      : _chatMessageFactory = chatMessageFactory;

  final ChatMessageFactory _chatMessageFactory;

  @override
  Widget create(BuildContext context, MessageChatSetTtlTileModel model) {
    return _chatMessageFactory.createChatNotificationFromText(
      id: model.id,
      context: context,
      text: model.title.toInlineSpan(),
    );
  }
}
