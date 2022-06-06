import 'package:feature_chat_impl/src/tile/model/tile_model.dart';
import 'package:feature_chat_impl/src/widget/chat_message/chat_message_factory.dart';
import 'package:flutter/material.dart';
import 'package:tile/tile.dart';

import 'not_implemented.dart';

class MessageVideoChatEndedTileFactoryDelegate
    implements ITileFactoryDelegate<MessageVideoChatEndedTileModel> {
  MessageVideoChatEndedTileFactoryDelegate({
    required ChatMessageFactory chatMessageFactory,
  }) : _chatMessageFactory = chatMessageFactory;

  final ChatMessageFactory _chatMessageFactory;

  @override
  Widget create(
    BuildContext context,
    MessageVideoChatEndedTileModel model,
  ) {
    return _chatMessageFactory.create(
      context: context,
      isOutgoing: model.isOutgoing,
      body: NotImplementedWidget(type: model.type),
    );
  }
}
