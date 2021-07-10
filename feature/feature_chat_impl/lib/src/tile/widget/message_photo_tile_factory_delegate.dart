import 'package:coreui/coreui.dart';
import 'package:feature_chat_impl/src/tile/model/tile_model.dart';
import 'package:feature_chat_impl/src/util/minithumbnail.dart';
import 'package:feature_chat_impl/src/widget/chat_message/chat_message_factory.dart';
import 'package:feature_chat_impl/src/widget/media_widget.dart';
import 'package:flutter/material.dart';

class MessagePhotoTileFactoryDelegate
    implements ITileFactoryDelegate<MessagePhotoTileModel> {
  MessagePhotoTileFactoryDelegate(
      {required ChatMessageFactory chatMessageFactory})
      : _chatMessageFactory = chatMessageFactory;

  final ChatMessageFactory _chatMessageFactory;

  @override
  Widget create(BuildContext context, MessagePhotoTileModel model) {
    return _chatMessageFactory.create(
      id: model.id,
      context: context,
      isOutgoing: model.isOutgoing,
      body: MediaWidget(
          child: Image.memory(
            model.minithumbnail!.data!,
            fit: BoxFit.fill,
          ),
          aspectRatio: model.minithumbnail!.aspectRatio()),
    );
  }
}
