import 'package:coreui/coreui.dart';
import 'package:feature_chat_impl/feature_chat_impl.dart';
import 'package:feature_chat_impl/src/tile/model/tile_model.dart';
import 'package:feature_chat_impl/src/util/minithumbnail.dart';
import 'package:feature_chat_impl/src/widget/chat_message/sender_avatar_factory.dart';
import 'package:feature_chat_impl/src/widget/widget.dart';
import 'package:flutter/material.dart';

class MessageVideoTileFactoryDelegate
    implements ITileFactoryDelegate<MessageVideoTileModel> {
  MessageVideoTileFactoryDelegate({
    required SenderAvatarFactory senderAvatarFactory,
    required ChatMessageFactory chatMessageFactory,
    required SenderTitleFactory senderTitleFactory,
    required ShortInfoFactory shortInfoFactory,
    required ReplyInfoFactory replyInfoFactory,
  })  : _chatMessageFactory = chatMessageFactory,
        _shortInfoFactory = shortInfoFactory,
        _senderAvatarFactory = senderAvatarFactory,
        _senderTitleFactory = senderTitleFactory,
        _replyInfoFactory = replyInfoFactory;

  final SenderTitleFactory _senderTitleFactory;
  final ChatMessageFactory _chatMessageFactory;
  final ReplyInfoFactory _replyInfoFactory;
  final ShortInfoFactory _shortInfoFactory;
  final SenderAvatarFactory _senderAvatarFactory;

  @override
  Widget create(BuildContext context, MessageVideoTileModel model) {
    // todo handle nullable minithumbnail
    if (model.minithumbnail == null) {
      return const NotImplementedPlaceholder(
        additional: 'minithumbnail is null',
      );
    }

    return _chatMessageFactory.createConversationMessage(
        id: model.id,
        isOutgoing: model.isOutgoing,
        context: context,
        senderTitle: _senderTitleFactory.createFromMessageModel(context, model),
        reply: _replyInfoFactory.createFromMessageModel(context, model),
        avatar: _senderAvatarFactory.create(context, model.senderInfo),
        blocks: <Widget>[
          MediaWrapper(
              type: MediaType.Video,
              child: Container(
                color: Colors.black,
                child: const NotImplementedPlaceholder(
                  additional: 'MessageVideo',
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
