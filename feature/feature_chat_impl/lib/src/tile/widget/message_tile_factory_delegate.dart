import 'package:coreui/coreui.dart';
import 'package:feature_chat_impl/src/tile/model/message_tile_model.dart';
import 'package:feature_chat_impl/src/widget/chat_message/chat_message_factory.dart';
import 'package:flutter/material.dart';

class MessageTileFactoryDelegate
    implements ITileFactoryDelegate<MessageTileModel> {
  MessageTileFactoryDelegate({required ChatMessageFactory chatMessageFactory})
      : _chatMessageFactory = chatMessageFactory;

  final ChatMessageFactory _chatMessageFactory;

  @override
  Widget create(BuildContext context, MessageTileModel model) {
    return _chatMessageFactory.create(context, model.message);
  }
}
