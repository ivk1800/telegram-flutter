import 'package:core_utils/core_utils.dart';
import 'package:feature_chat_impl/feature_chat_impl.dart';
import 'package:feature_chat_impl/src/widget/widget.dart';
import 'package:flutter/material.dart';
import 'package:tile/tile.dart';

class MessageAnimationTileFactoryDelegate
    implements ITileFactoryDelegate<MessageAnimationTileModel> {
  MessageAnimationTileFactoryDelegate({
    required ChatMessageFactory chatMessageFactory,
    required ShortInfoFactory shortInfoFactory,
    required ReplyInfoFactory replyInfoFactory,
  })  : _chatMessageFactory = chatMessageFactory,
        _shortInfoFactory = shortInfoFactory,
        _replyInfoFactory = replyInfoFactory;

  final ChatMessageFactory _chatMessageFactory;
  final ReplyInfoFactory _replyInfoFactory;
  final ShortInfoFactory _shortInfoFactory;

  @override
  Widget create(BuildContext context, MessageAnimationTileModel model) {
    // todo handle nullable minithumbnail
    if (model.minithumbnail == null) {
      return const NotImplementedPlaceholder(
        additional: 'minithumbnail is null',
      );
    }

    final ChatContextData chatContextData = ChatContext.of(context);

    return _chatMessageFactory.createConversationMessage(
      id: model.id,
      context: context,
      isOutgoing: model.isOutgoing,
      senderTitle: null,
      reply: _replyInfoFactory.createFromMessageModel(context, model),
      blocks: <Widget>[
        MediaWrapper(
          type: MediaType.animation,
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
            padding: EdgeInsets.only(
              left: chatContextData.horizontalPadding,
              right: chatContextData.horizontalPadding,
              top: chatContextData.verticalPadding,
            ),
            text: model.caption!,
            shortInfo: _shortInfoFactory.create(
              context: context,
              additionalInfo: model.additionalInfo,
              isOutgoing: model.isOutgoing,
              padding: EdgeInsets.only(bottom: chatContextData.verticalPadding),
            ),
          ),
      ],
    );
  }
}
