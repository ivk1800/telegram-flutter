import 'package:chat_theme/chat_theme.dart';
import 'package:feature_chat_impl/src/tile/model/base_conversation_message_tile_model.dart';
import 'package:feature_chat_impl/src/widget/chat_context.dart';
import 'package:flutter/material.dart';
import 'package:tg_theme/tg_theme.dart';

class ReplyInfoFactory {
  const ReplyInfoFactory();

  Widget? createFromMessageModel(
    BuildContext context,
    BaseConversationMessageTileModel messageModel,
  ) {
    final ReplyInfo? replyInfo = messageModel.replyInfo;
    if (replyInfo == null) {
      return null;
    }

    return _Decoration(child: _Body(replyInfo: replyInfo));
  }
}

class _Painter extends CustomPainter {
  _Painter({required Color lineColor})
      : _paint = Paint()
          ..color = lineColor
          ..strokeWidth = 2;

  final Paint _paint;

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawLine(
      const Offset(horOffsetX, 0),
      Offset(horOffsetX, size.height),
      _paint,
    );
  }

  @override
  bool shouldRepaint(_Painter oldDelegate) {
    return _paint != oldDelegate._paint;
  }

  static const double horOffsetX = 8;
}

class _Decoration extends StatelessWidget {
  const _Decoration({
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final ChatContextData chatContextData = ChatContext.of(context);
    final ChatThemeData chatTheme = TgTheme.of(context).themeOf();
    return Padding(
      padding: EdgeInsets.only(
        right: chatContextData.horizontalPadding,
        bottom: chatContextData.verticalPadding,
      ),
      child: CustomPaint(
        child: Padding(
          padding: const EdgeInsets.only(left: 16),
          child: child,
        ),
        painter: _Painter(
          lineColor: chatTheme.replyTitle.color!,
        ),
      ),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body({
    required this.replyInfo,
  });

  final ReplyInfo replyInfo;

  @override
  Widget build(BuildContext context) {
    final ChatThemeData chatTheme = TgTheme.of(context).themeOf();

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                replyInfo.title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: chatTheme.replyTitle,
              ),
              Text(
                replyInfo.subtitle,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: chatTheme.replySubtitle,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
