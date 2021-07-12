import 'package:coreui/coreui.dart';
import 'package:feature_chat_impl/feature_chat_impl.dart';
import 'package:feature_chat_impl/src/tile/model/tile_model.dart';
import 'package:feature_chat_impl/src/widget/chat_message/chat_message_factory.dart';
import 'package:feature_chat_impl/src/widget/chat_message/short_info_factory.dart';
import 'package:feature_chat_impl/src/widget/message_text.dart';
import 'package:flutter/material.dart';

class MessageAudioTileFactoryDelegate
    implements ITileFactoryDelegate<MessageAudioTileModel> {
  MessageAudioTileFactoryDelegate(
      {required ShortInfoFactory shortInfoFactory,
      required ChatMessageFactory chatMessageFactory})
      : _shortInfoFactory = shortInfoFactory,
        _chatMessageFactory = chatMessageFactory;

  final ChatMessageFactory _chatMessageFactory;
  final ShortInfoFactory _shortInfoFactory;

  @override
  Widget create(BuildContext context, MessageAudioTileModel model) {
    final ChatContextData chatContext = ChatContext.of(context);
    final ThemeData theme = Theme.of(context);
    return _chatMessageFactory.createFromBlocks(
        id: model.id,
        context: context,
        isOutgoing: model.isOutgoing,
        blocks: <Widget>[
          Padding(
            padding: EdgeInsets.only(
                top: chatContext.verticalPadding,
                bottom: chatContext.verticalPadding,
                right: chatContext.horizontalPadding,
                left: chatContext.horizontalPadding),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                // todo implement play button
                const CircleAvatar(
                  radius: 25,
                ),
                const SizedBox(
                  width: 8,
                ),
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text(
                        model.title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: theme.textTheme.bodyText1,
                      ),
                      Text(
                        model.performer,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: theme.textTheme.bodyText1,
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      MessageText(
                        text: TextSpan(
                          text: '00:00 / ${model.totalDuration}',
                          style: theme.textTheme.caption,
                        ),
                        shortInfo: _shortInfoFactory.create(context),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ]);
  }
}
