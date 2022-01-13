import 'package:core_utils/core_utils.dart';
import 'package:coreui/coreui.dart';
import 'package:feature_chat_impl/feature_chat_impl.dart';
import 'package:feature_chat_impl/src/resolver/message_component_resolver.dart';
import 'package:feature_chat_impl/src/widget/widget.dart';
import 'package:flutter/material.dart';
import 'package:tile/tile.dart';

class MessageVideoTileFactoryDelegate
    implements ITileFactoryDelegate<MessageVideoTileModel> {
  MessageVideoTileFactoryDelegate({
    required ChatMessageFactory chatMessageFactory,
    required MessageComponentResolver messageComponentResolver,
    required ShortInfoFactory shortInfoFactory,
    required ImageWidgetFactory imageWidgetFactory,
    required ReplyInfoFactory replyInfoFactory,
  })  : _chatMessageFactory = chatMessageFactory,
        _shortInfoFactory = shortInfoFactory,
        _imageWidgetFactory = imageWidgetFactory,
        _messageComponentResolver = messageComponentResolver,
        _replyInfoFactory = replyInfoFactory;

  final ChatMessageFactory _chatMessageFactory;
  final ImageWidgetFactory _imageWidgetFactory;
  final ReplyInfoFactory _replyInfoFactory;
  final ShortInfoFactory _shortInfoFactory;
  final MessageComponentResolver _messageComponentResolver;

  @override
  Widget create(BuildContext context, MessageVideoTileModel model) {
    return _chatMessageFactory.createConversationMessage(
      id: model.id,
      isOutgoing: model.isOutgoing,
      context: context,
      senderTitle: _messageComponentResolver.resolveSenderName(context, model),
      reply: _replyInfoFactory.createFromMessageModel(context, model),
      blocks: <Widget>[
        MediaWrapper(
          type: MediaType.video,
          child: _imageWidgetFactory.create(
            context,
            minithumbnail: model.minithumbnail,
            imageId: model.thumbnailImageId,
          ),
          aspectRatio: model.minithumbnail!.aspectRatio(),
        ),
        if (model.caption != null)
          MessageCaption(
            text: model.caption!,
            shortInfo: _shortInfoFactory.create(context, model.additionalInfo),
          ),
      ],
    );
  }
}
