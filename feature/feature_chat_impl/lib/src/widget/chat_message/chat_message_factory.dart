import 'package:coreui/coreui.dart';
import 'package:feature_chat_impl/src/widget/bubble/bubble.dart';
import 'package:feature_chat_impl/src/widget/chat_context.dart';
import 'package:feature_chat_impl/src/widget/message/message_content.dart';
import 'package:feature_chat_impl/src/widget/message/message_skeleton.dart';
import 'package:feature_chat_impl/src/widget/theme/chat_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:jugger/jugger.dart' as j;

class ChatMessageFactory {
  @j.inject
  ChatMessageFactory({required AvatarWidgetFactory avatarWidgetFactory})
      : _avatarWidgetFactory = avatarWidgetFactory;

  final AvatarWidgetFactory _avatarWidgetFactory;

  @Deprecated('use another')
  Widget create(
      {required int id,
      required BuildContext context,
      required bool isOutgoing,
      required Widget body}) {
    final ChatContextData chatContext = ChatContext.of(context);
    return Align(
      key: ValueKey<int>(id),
      alignment: isOutgoing ? Alignment.topRight : Alignment.topLeft,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          constraints: BoxConstraints(maxWidth: chatContext.maxWidth),
          child: _buildMessageBubble(
              context: context,
              isOutgoing: isOutgoing,
              child: MessageSkeleton(
                content: body,
                shortInfo: Padding(
                  padding: const EdgeInsets.only(left: 4, top: 4),
                  child: Text(
                    '22:46',
                    style: Theme.of(context).textTheme.caption,
                  ),
                ),
              )),
        ),
      ),
    );
  }

  Widget createFromBlocks(
      {required int id,
      required BuildContext context,
      required bool isOutgoing,
      required List<Widget> blocks}) {
    final ChatContextData chatContext = ChatContext.of(context);
    return Align(
      key: ValueKey<int>(id),
      alignment: isOutgoing ? Alignment.topRight : Alignment.topLeft,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          constraints: BoxConstraints(maxWidth: chatContext.maxWidth),
          child: _buildMessageBubble(
              context: context,
              isOutgoing: isOutgoing,
              child: MessageContent(
                children: blocks,
              )),
        ),
      ),
    );
  }

  Widget _buildMessageBubble(
      {required BuildContext context,
      required bool isOutgoing,
      required Widget child}) {
    final ChatThemeData theme = ChatTheme.of(context);
    return Bubble(
        radius: 10,
        child: Container(
            color: isOutgoing ? theme.bubbleOutgoingColor : theme.bubbleColor,
            child: child));
  }
}
