import 'package:core_utils/core_utils.dart';
import 'package:coreui/coreui.dart';
import 'package:feature_chat_impl/feature_chat_impl.dart';
import 'package:feature_chat_impl/src/resolver/message_component_resolver.dart';
import 'package:feature_chat_impl/src/tile/model/tile_model.dart';
import 'package:feature_chat_impl/src/widget/widget.dart';
import 'package:flutter/material.dart';
import 'package:rich_text_format_flutter/rich_text_format_flutter.dart';
import 'package:tile/tile.dart';

class MessagePhotoTileFactoryDelegate
    implements ITileFactoryDelegate<MessagePhotoTileModel> {
  MessagePhotoTileFactoryDelegate({
    required ChatMessageFactory chatMessageFactory,
    required ShortInfoFactory shortInfoFactory,
    required ImageWidgetFactory imageWidgetFactory,
    required MessageComponentResolver messageComponentResolver,
    required ReplyInfoFactory replyInfoFactory,
  })  : _chatMessageFactory = chatMessageFactory,
        _imageWidgetFactory = imageWidgetFactory,
        _messageComponentResolver = messageComponentResolver,
        _shortInfoFactory = shortInfoFactory,
        _replyInfoFactory = replyInfoFactory;

  final ChatMessageFactory _chatMessageFactory;
  final ReplyInfoFactory _replyInfoFactory;
  final ShortInfoFactory _shortInfoFactory;
  final ImageWidgetFactory _imageWidgetFactory;
  final MessageComponentResolver _messageComponentResolver;

  @override
  Widget create(BuildContext context, MessagePhotoTileModel model) {
    return _chatMessageFactory.createConversationMessage(
      id: model.id,
      isOutgoing: model.isOutgoing,
      context: context,
      senderTitle: _messageComponentResolver.resolveSenderName(context, model),
      reply: _replyInfoFactory.createFromMessageModel(context, model),
      avatar: _messageComponentResolver.resolveAvatar(context, model),
      blocks: <Widget>[
        MediaWrapper(
          type: MediaType.Animation,
          child: _imageWidgetFactory.create(
            context,
            minithumbnail: model.minithumbnail,
            imageId: model.photoId,
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
