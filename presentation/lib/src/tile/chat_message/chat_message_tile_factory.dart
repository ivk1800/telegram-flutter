import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:tdlib/td_api.dart' as td;
import 'package:jugger/jugger.dart' as j;

import 'add_members_tile_factory.dart';
import 'message_text_tile_factory.dart';

class ChatMessageTileFactory {
  @j.inject
  ChatMessageTileFactory(this._messageTextFactory, this._addMembersFactory);

  final MessageTextTileFactory _messageTextFactory;
  final AddMembersTileFactory _addMembersFactory;

  Widget create(BuildContext context, td.Message message) {
    return _build(context, message);
  }

  Widget _build(BuildContext context, td.Message message) {
    switch (message.content.getConstructor()) {
      case td.MessageText.CONSTRUCTOR:
        {
          return _messageTextFactory.create(
              context, message, message.content as td.MessageText);
        }
      case td.MessageChatAddMembers.CONSTRUCTOR:
        {
          return _addMembersFactory.create(
              context, message, message.content as td.MessageChatAddMembers);
        }
    }

    return ListTile(
      title: Text(message.content.runtimeType.toString()),
      subtitle: const Text('not implemented'),
    );
  }
}
