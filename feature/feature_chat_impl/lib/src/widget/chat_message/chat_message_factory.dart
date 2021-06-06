import 'package:coreui/coreui.dart';
import 'package:feature_chat_impl/src/widget/bubble/bubble.dart';
import 'package:feature_chat_impl/src/widget/message/message_skeleton.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:tdlib/td_api.dart' as td;
import 'package:jugger/jugger.dart' as j;

import 'content/add_members_tile_factory.dart';
import 'content/message_text_content_factory.dart';

class ChatMessageFactory {
  @j.inject
  ChatMessageFactory(this._messageTextFactory, this._addMembersFactory,
      this._avatarWidgetFactory);

  final AvatarWidgetFactory _avatarWidgetFactory;
  final MessageTextContentFactory _messageTextFactory;
  final AddMembersTileFactory _addMembersFactory;

  Widget create(BuildContext context, td.Message message) {
    return Align(
      alignment: message.isOutgoing ? Alignment.topRight : Alignment.topLeft,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          constraints: const BoxConstraints(maxWidth: 500),
          child: _buildMessageBubble(context, message),
        ),
      ),
    );
  }

  Widget _buildMessageBubble(BuildContext context, td.Message message) {
    return Bubble(
        radius: 10,
        child: Container(
            padding: const EdgeInsets.all(8),
            color: Colors.grey,
            child: MessageSkeleton(
              content: _buildContent(context, message),
              // content: Container(color: Colors.blue, height: 30,),
              shortInfo: Padding(
                padding: const EdgeInsets.only(left: 4, top: 4),
                child: Text(
                  '22:46',
                  style: Theme.of(context).textTheme.caption,
                ),
              ),
            )));
  }

  Widget _buildContent(BuildContext context, td.Message message) {
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

    return Text(
      'not implemented ${message.content.runtimeType}',
      style: Theme.of(context)
          .textTheme
          .subtitle1!
          .copyWith(color: Colors.redAccent),
    );
  }
}
