import 'package:chat_theme/chat_theme.dart';
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
    required int id,
    required BuildContext context,
    required rt.RichText text,
  }) {
    return _Notification(
      key: ValueKey<int>(id),
      child: Text.rich(
        text.toInlineSpan(context),
        textAlign: TextAlign.center,
        // todo extract style
        style: const TextStyle(color: Colors.white),
      ),
    );
  }

  // todo move to another class for message parts
  Widget createChatNotificationBubble({required InlineSpan span}) =>
      _Notification(
        child: Text.rich(
          span,
          textAlign: TextAlign.center,
          // todo extract style
          style: const TextStyle(color: Colors.white),
        ),
      );

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
    required int id,
    required BuildContext context,
    required bool isOutgoing,
    required Widget body,
  }) {
    return _BaseMessage(
      id: id,
      alignment: isOutgoing ? Alignment.topRight : Alignment.topLeft,
      body: _Bubble(
        isOutgoing: isOutgoing,
        child: body,
      ),
    );
  }

  Widget createCustom({
    required int id,
    required BuildContext context,
    required AlignmentGeometry alignment,
    required Widget body,
  }) {
    return _BaseMessage(
      id: id,
      alignment: alignment,
      body: body,
    );
  }

  Widget createConversationMessage({
    required int id,
    required BuildContext context,
    required Widget? reply,
    required Widget? senderTitle,
    required List<Widget> blocks,
    required bool isOutgoing,
    required Widget? avatar,
  }) {
    return createFromBlocks(
      id: id,
      context: context,
      isOutgoing: isOutgoing,
      leading: avatar,
      blocks: <Widget>[
        if (senderTitle != null) senderTitle,
        if (reply != null) reply,
        ...blocks,
      ],
    );
  }

  Widget createFromBlocks({
    required int id,
    required BuildContext context,
    required bool isOutgoing,
    required List<Widget> blocks,
    Widget? leading,
  }) {
    return _BaseMessage(
      id: id,
      alignment: isOutgoing ? Alignment.topRight : Alignment.topLeft,
      body: _Leading(
        leading: leading,
        body: _BaseMessage(
          id: id,
          alignment: isOutgoing ? Alignment.topRight : Alignment.topLeft,
          body: _Bubble(
            child: MessageContent(
              children: blocks,
            ),
            isOutgoing: isOutgoing,
          ),
        ),
      ),
    );
  }
}

class _BaseMessage extends StatelessWidget {
  const _BaseMessage({
    Key? key,
    required this.id,
    required this.alignment,
    required this.body,
  }) : super(key: key);

  final int id;
  final AlignmentGeometry alignment;
  final Widget body;

  @override
  Widget build(BuildContext context) {
    final ChatContextData chatContext = ChatContext.of(context);
    return Align(
      key: ValueKey<int>(id),
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
    Key? key,
  }) : super(key: key);

  final bool isOutgoing;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final ChatThemeData theme = TgTheme.of(context).themeOf();
    return Bubble(
      radius: 10,
      child: Container(
        color: isOutgoing ? theme.bubbleOutgoingColor : theme.bubbleColor,
        child: child,
      ),
    );
  }
}

class _Leading extends StatelessWidget {
  const _Leading({
    required this.leading,
    required this.body,
    Key? key,
  }) : super(key: key);

  final Widget? leading;
  final Widget body;

  @override
  Widget build(BuildContext context) {
    if (leading == null) {
      return body;
    }

    return Row(
      // todo need pass from args for different cases
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[leading!, Flexible(child: body)],
    );
  }
}

class _Notification extends StatelessWidget {
  const _Notification({
    required this.child,
    Key? key,
  }) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: Container(
        child: child,
        padding: const EdgeInsets.only(top: 3, bottom: 3, left: 6, right: 6),
        decoration: BoxDecoration(
          // todo extract color to styles
          color: Colors.black.withAlpha(60),
          borderRadius: const BorderRadius.all(Radius.circular(16.0)),
        ),
      ),
    );
  }
}
