import 'package:core_utils/core_utils.dart';
import 'package:feature_chat_impl/feature_chat_impl.dart';
import 'package:feature_chat_impl/src/resolver/message_component_resolver.dart';
import 'package:feature_chat_impl/src/tile/model/tile_model.dart';
import 'package:feature_chat_impl/src/widget/widget.dart';
import 'package:flutter/material.dart';
import 'package:rich_text_format_flutter/rich_text_format_flutter.dart';
import 'package:tile/tile.dart';

class MessageAnimationTileFactoryDelegate
    implements ITileFactoryDelegate<MessageAnimationTileModel> {
  MessageAnimationTileFactoryDelegate({
    required ChatMessageFactory chatMessageFactory,
    required ShortInfoFactory shortInfoFactory,
    required MessageComponentResolver messageComponentResolver,
    required ReplyInfoFactory replyInfoFactory,
  })  : _chatMessageFactory = chatMessageFactory,
        _shortInfoFactory = shortInfoFactory,
        _messageComponentResolver = messageComponentResolver,
        _replyInfoFactory = replyInfoFactory;

  final ChatMessageFactory _chatMessageFactory;
  final ReplyInfoFactory _replyInfoFactory;
  final MessageComponentResolver _messageComponentResolver;
  final ShortInfoFactory _shortInfoFactory;

  @override
  Widget create(BuildContext context, MessageAnimationTileModel model) {
    // todo handle nullable minithumbnail
    if (model.minithumbnail == null) {
      return const NotImplementedPlaceholder(
        additional: 'minithumbnail is null',
      );
    }

    return _chatMessageFactory.createConversationMessage(
      id: model.id,
      context: context,
      isOutgoing: model.isOutgoing,
      senderTitle: _messageComponentResolver.resolveSenderName(context, model),
      reply: _replyInfoFactory.createFromMessageModel(context, model),
      avatar: _messageComponentResolver.resolveAvatar(context, model),
      blocks: <Widget>[
        MediaWrapper(
          type: MediaType.Animation,
          child: Container(
            color: Colors.black,
            child: const NotImplementedPlaceholder(
              additional: 'MessageAnimation',
            ),
          ),
          aspectRatio: model.minithumbnail!.aspectRatio(),
        ),
        if (model.caption != null)
          MessageCaption(
            text: model.caption!.toInlineSpan(),
            shortInfo: _shortInfoFactory.create(context, model.additionalInfo),
          ),
      ],
    );
  }
}
