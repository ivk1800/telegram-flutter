import 'package:core_utils/core_utils.dart';
import 'package:feature_chat_impl/src/tile/model/tile_model.dart';
import 'package:feature_chat_impl/src/widget/chat_message/chat_message_factory.dart';
import 'package:flutter/material.dart';
import 'package:tile/tile.dart';
import 'package:rich_text_format_flutter/rich_text_format_flutter.dart';

class MessageChatChangePhotoTileFactoryDelegate
    implements ITileFactoryDelegate<MessageChatChangePhotoTileModel> {
  MessageChatChangePhotoTileFactoryDelegate(
      {required ChatMessageFactory chatMessageFactory})
      : _chatMessageFactory = chatMessageFactory;

  final ChatMessageFactory _chatMessageFactory;

  @override
  Widget create(BuildContext context, MessageChatChangePhotoTileModel model) {
    return _chatMessageFactory.createCustom(
        id: model.id,
        context: context,
        alignment: Alignment.center,
        body: Column(
          children: <Widget>[
            _chatMessageFactory.createChatNotificationBubbleFromText(
              text: model.title.toInlineSpan(),
            ),
            const SizedBox(
              height: 8,
            ),
            // todo implement avatar loading
            CircleAvatar(
              radius: 90,
              backgroundImage: model.minithumbnail?.toMemoryImage(),
            )
          ],
        ));
  }
}
