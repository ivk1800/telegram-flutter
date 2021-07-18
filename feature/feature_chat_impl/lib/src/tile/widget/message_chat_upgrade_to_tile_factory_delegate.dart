import 'package:coreui/coreui.dart';
import 'package:feature_chat_impl/src/tile/model/tile_model.dart';
import 'package:feature_chat_impl/src/widget/chat_message/chat_message_factory.dart';
import 'package:flutter/material.dart';

import 'not_implemented.dart';

class MessageChatUpgradeToTileFactoryDelegate
    implements ITileFactoryDelegate<MessageChatUpgradeToTileModel> {
  MessageChatUpgradeToTileFactoryDelegate(
      {required ChatMessageFactory chatMessageFactory})
      : _chatMessageFactory = chatMessageFactory;

  final ChatMessageFactory _chatMessageFactory;

  @override
  Widget create(BuildContext context, MessageChatUpgradeToTileModel model) {
    return _chatMessageFactory.createChatNotificationFromText(
        id: model.id, context: context, text: model.title);
  }
}
