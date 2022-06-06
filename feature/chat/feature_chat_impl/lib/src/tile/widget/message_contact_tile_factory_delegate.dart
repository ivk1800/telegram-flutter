import 'package:feature_chat_impl/feature_chat_impl.dart';
import 'package:feature_chat_impl/src/resolver/message_component_resolver.dart';
import 'package:feature_chat_impl/src/widget/widget.dart';
import 'package:flutter/material.dart';
import 'package:localization_api/localization_api.dart';
import 'package:tile/tile.dart';

class MessageContactTileFactoryDelegate
    implements ITileFactoryDelegate<MessageContactTileModel> {
  MessageContactTileFactoryDelegate({
    required ChatMessageFactory chatMessageFactory,
    required IStringsProvider stringsProvider,
    required MessageComponentResolver messageComponentResolver,
    required ReplyInfoFactory replyInfoFactory,
    required ShortInfoFactory shortInfoFactory,
  })  : _chatMessageFactory = chatMessageFactory,
        _replyInfoFactory = replyInfoFactory,
        _messageComponentResolver = messageComponentResolver,
        _stringsProvider = stringsProvider,
        _shortInfoFactory = shortInfoFactory;

  final ChatMessageFactory _chatMessageFactory;
  final ShortInfoFactory _shortInfoFactory;
  final IStringsProvider _stringsProvider;
  final ReplyInfoFactory _replyInfoFactory;
  final MessageComponentResolver _messageComponentResolver;

  @override
  Widget create(BuildContext context, MessageContactTileModel model) {
    final ChatContextData chatContext = ChatContext.of(context);
    // todo specify value from ref(ios, android)
    // todo move to config
    const double maxWidth = 220;
    return _chatMessageFactory.createConversationMessage(
      isOutgoing: model.isOutgoing,
      context: context,
      senderTitle: _messageComponentResolver.resolveSenderName(context, model),
      reply: _replyInfoFactory.createFromMessageModel(context, model),
      blocks: <Widget>[
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: maxWidth),
          child: Padding(
            padding: EdgeInsets.only(
              left: chatContext.horizontalPadding,
              right: chatContext.horizontalPadding,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                // todo replace ListTile by own layout
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  minVerticalPadding: 0,
                  // todo display avatar
                  leading: const CircleAvatar(),
                  title: Text(
                    model.title,
                    maxLines: 1,
                  ),
                  subtitle: Text(
                    model.subtitle,
                    maxLines: 1,
                  ),
                  // todo handle tap
                  trailing: const Icon(Icons.more_vert),
                ),
                OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    minimumSize: const Size(maxWidth, 40),
                  ),
                  onPressed: () {
                    // todo handle tap
                  },
                  child: Text(
                    _stringsProvider.viewContact,
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 4, top: 4),
                    child: _shortInfoFactory.create(
                      context: context,
                      additionalInfo: model.additionalInfo,
                      isOutgoing: model.isOutgoing,
                      padding: EdgeInsets.only(
                        bottom: chatContext.verticalPadding,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
