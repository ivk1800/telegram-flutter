import 'package:coreui/coreui.dart';
import 'package:feature_chat_impl/src/tile/model/tile_model.dart';
import 'package:feature_chat_impl/src/widget/widget.dart';
import 'package:flutter/material.dart';

class MessageTextTileFactoryDelegate
    implements ITileFactoryDelegate<MessageTextTileModel> {
  MessageTextTileFactoryDelegate({
    required ChatMessageFactory chatMessageFactory,
    required SenderTitleFactory senderTitleFactory,
    required ShortInfoFactory shortInfoFactory,
    required ReplyInfoFactory replyInfoFactory,
  })  : _chatMessageFactory = chatMessageFactory,
        _senderTitleFactory = senderTitleFactory,
        _shortInfoFactory = shortInfoFactory,
        _replyInfoFactory = replyInfoFactory;

  final ChatMessageFactory _chatMessageFactory;
  final ReplyInfoFactory _replyInfoFactory;
  final SenderTitleFactory _senderTitleFactory;
  final ShortInfoFactory _shortInfoFactory;

  @override
  Widget create(BuildContext context, MessageTextTileModel model) {
    return _chatMessageFactory.createConversationMessage(
        id: model.id,
        isOutgoing: model.isOutgoing,
        context: context,
        senderTitle: _senderTitleFactory.createFromMessageModel(context, model),
        reply: _replyInfoFactory.createFromMessageModel(context, model),
        blocks: <Widget>[
          MessageCaption(
            text: model.text,
            shortInfo: _shortInfoFactory.create(context, model.additionalInfo),
          ),
        ]);
  }
}
