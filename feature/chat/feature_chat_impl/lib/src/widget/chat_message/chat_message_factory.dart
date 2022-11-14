import 'package:chat_theme/chat_theme.dart';
import 'package:coreui/coreui.dart';
import 'package:feature_chat_impl/src/widget/bubble/bubble.dart';
import 'package:feature_chat_impl/src/widget/chat_context.dart';
import 'package:feature_chat_impl/src/widget/message/message_content.dart';
import 'package:flutter/material.dart';
import 'package:rich_text_format/rich_text_format.dart' as rt;
import 'package:rich_text_format_flutter/rich_text_format_flutter.dart';
import 'package:tg_theme/tg_theme.dart';

class ChatMessageFactory {
  const ChatMessageFactory();

  Widget createChatNotificationFromText({
    required BuildContext context,
    required rt.RichText text,
  }) {
    return _Notification(
      // TODO wrap to DefaultTextStyle for custom emoji
      text: text.toInlineSpan(context),
    );
  }

  // todo move to another class for message parts
  Widget createChatNotificationBubble({required InlineSpan span}) =>
      _Notification(text: span);

  Widget createChatNotification({
    required int id,
    required BuildContext context,
    required Widget body,
  }) {
    return Align(
      key: ValueKey<int>(id),
      alignment: Alignment.topCenter,
      child: Container(
        child: body,
        padding: const EdgeInsets.only(top: 3, bottom: 3, left: 6, right: 6),
        decoration: BoxDecoration(
          // todo extract color to styles
          color: Colors.black.withAlpha(60),
          borderRadius: const BorderRadius.all(Radius.circular(16.0)),
        ),
      ),
    );
  }

  Widget create({
    required BuildContext context,
    required bool isOutgoing,
    required Widget body,
    bool withBubble = true,
  }) {
    return _BaseMessage(
      alignment: isOutgoing ? Alignment.topRight : Alignment.topLeft,
      body: withBubble ? _Bubble(isOutgoing: isOutgoing, child: body) : body,
    );
  }

  Widget createCustom({
    required BuildContext context,
    required AlignmentGeometry alignment,
    required Widget body,
  }) {
    return _BaseMessage(
      alignment: alignment,
      body: body,
    );
  }

  Widget createConversationMessage({
    required BuildContext context,
    required Widget? reply,
    required Widget? senderTitle,
    required List<Widget> blocks,
    required bool isOutgoing,
  }) {
    return createFromBlocks(
      context: context,
      isOutgoing: isOutgoing,
      blocks: <Widget>[
        if (senderTitle != null) senderTitle,
        if (reply != null) reply,
        ...blocks,
      ],
    );
  }

  Widget createFromBlocks({
    required BuildContext context,
    required bool isOutgoing,
    required List<Widget> blocks,
    bool withBubble = true,
  }) {
    return _BaseMessage(
      alignment: isOutgoing ? Alignment.topRight : Alignment.topLeft,
      body: withBubble
          ? _Bubble(
              child: MessageContent(
                children: blocks,
              ),
              isOutgoing: isOutgoing,
            )
          : MessageContent(children: blocks),
    );
  }
}

class _BaseMessage extends StatelessWidget {
  const _BaseMessage({
    required this.alignment,
    required this.body,
  });

  final AlignmentGeometry alignment;
  final Widget body;

  @override
  Widget build(BuildContext context) {
    final ChatContextData chatContext = ChatContext.of(context);
    return Align(
      alignment: alignment,
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: chatContext.maxWidth),
        child: body,
      ),
    );
  }
}

class _Bubble extends StatelessWidget {
  const _Bubble({
    required this.isOutgoing,
    required this.child,
  });

  final bool isOutgoing;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final ChatThemeData theme = TgTheme.of(context).themeOf();
    return Bubble(
      borderColor: isOutgoing
          ? theme.bubbleOutgoingBorderColor
          : theme.bubbleIncomingBorderColor,
      radius: 10,
      child: ColoredBox(
        color:
            isOutgoing ? theme.bubbleOutgoingColor : theme.bubbleIncomingColor,
        child: child,
      ),
    );
  }
}

class _Notification extends StatelessWidget {
  const _Notification({required this.text});

  final InlineSpan text;

  @override
  Widget build(BuildContext context) {
    final ChatThemeData chatTheme = TgTheme.of(context).themeOf();

    return TextBackground(
      margin: 8,
      backgroundColor: Colors.black26,
      child: Text.rich(
        text,
        textAlign: TextAlign.center,
        style: Theme.of(context)
            .textTheme
            .bodyMedium
            ?.copyWith(color: chatTheme.notificationTextColor),
      ),
    );
  }
}
