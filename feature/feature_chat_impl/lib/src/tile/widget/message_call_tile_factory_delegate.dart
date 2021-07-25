import 'package:coreui/coreui.dart';
import 'package:feature_chat_impl/feature_chat_impl.dart';
import 'package:feature_chat_impl/src/tile/model/tile_model.dart';
import 'package:feature_chat_impl/src/widget/chat_message/sender_avatar_factory.dart';
import 'package:feature_chat_impl/src/widget/widget.dart';
import 'package:flutter/material.dart';

class MessageCallTileFactoryDelegate
    implements ITileFactoryDelegate<MessageCallTileModel> {
  MessageCallTileFactoryDelegate({
    required ChatMessageFactory chatMessageFactory,
    required SenderTitleFactory senderTitleFactory,
    required SenderAvatarFactory senderAvatarFactory,
    required ReplyInfoFactory replyInfoFactory,
  })  : _chatMessageFactory = chatMessageFactory,
        _senderTitleFactory = senderTitleFactory,
        _senderAvatarFactory = senderAvatarFactory,
        _replyInfoFactory = replyInfoFactory;

  final ChatMessageFactory _chatMessageFactory;
  final ReplyInfoFactory _replyInfoFactory;
  final SenderTitleFactory _senderTitleFactory;
  final SenderAvatarFactory _senderAvatarFactory;

  @override
  Widget create(BuildContext context, MessageCallTileModel model) {
    final TextStyle captionStyle = Theme.of(context).textTheme.caption!;
    final ChatContextData contextData = ChatContext.of(context);

    return _chatMessageFactory.createConversationMessage(
        id: model.id,
        isOutgoing: model.isOutgoing,
        context: context,
        senderTitle: _senderTitleFactory.createFromMessageModel(context, model),
        reply: _replyInfoFactory.createFromMessageModel(context, model),
        avatar: _senderAvatarFactory.create(context, model.senderInfo),
        blocks: <Widget>[
          ConstrainedBox(
            // todo specify value from ref(ios, android)
            // todo move to config
            constraints: const BoxConstraints(minWidth: 250),
            child: Padding(
              padding: EdgeInsets.only(
                  top: contextData.verticalPadding,
                  bottom: contextData.verticalPadding,
                  right: contextData.horizontalPadding,
                  left: contextData.horizontalPadding),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Text(
                          model.title,
                          maxLines: 1,
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        RichText(
                          text: TextSpan(
                            style: captionStyle,
                            children: <InlineSpan>[
                              WidgetSpan(
                                // todo color icon
                                child: Icon(
                                    model.isOutgoing
                                        ? Icons.call_made
                                        : Icons.call_received,
                                    size: captionStyle.fontSize),
                              ),
                              TextSpan(
                                text: ' ${model.date}',
                              ),
                              if (model.duration != null)
                                TextSpan(
                                  text: ', ${model.duration}',
                                ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 4,
                  ),
                  // todo color icon
                  // todo ripple below container
                  IconButton(onPressed: () {}, icon: const Icon(Icons.call))
                ],
              ),
            ),
          )
        ]);
  }
}
