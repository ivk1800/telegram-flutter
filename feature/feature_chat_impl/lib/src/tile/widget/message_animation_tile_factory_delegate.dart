import 'package:coreui/coreui.dart';
import 'package:feature_chat_impl/feature_chat_impl.dart';
import 'package:feature_chat_impl/src/tile/model/tile_model.dart';
import 'package:feature_chat_impl/src/util/minithumbnail.dart';
import 'package:feature_chat_impl/src/widget/widget.dart';
import 'package:flutter/material.dart';

class MessageAnimationTileFactoryDelegate
    implements ITileFactoryDelegate<MessageAnimationTileModel> {
  MessageAnimationTileFactoryDelegate({
    required ChatMessageFactory chatMessageFactory,
    required ShortInfoFactory shortInfoFactory,
    required SenderTitleFactory senderTitleFactory,
    required ReplyInfoFactory replyInfoFactory,
  })  : _chatMessageFactory = chatMessageFactory,
        _shortInfoFactory = shortInfoFactory,
        _senderTitleFactory = senderTitleFactory,
        _replyInfoFactory = replyInfoFactory;

  final ChatMessageFactory _chatMessageFactory;
  final ReplyInfoFactory _replyInfoFactory;
  final SenderTitleFactory _senderTitleFactory;
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
        senderTitle: _senderTitleFactory.createFromMessageModel(context, model),
        reply: _replyInfoFactory.createFromMessageModel(context, model),
        blocks: <Widget>[
          MediaWrapper(
              type: MediaType.Animation,
              child: Container(
                color: Colors.black,
                child: const NotImplementedPlaceholder(
                  additional: 'MessageAnimation',
                ),
              ),
              aspectRatio: model.minithumbnail!.aspectRatio()),
          if (model.caption != null)
            MessageCaption(
              text: model.caption!,
              shortInfo:
                  _shortInfoFactory.create(context, model.additionalInfo),
            ),
        ]);
  }
}
