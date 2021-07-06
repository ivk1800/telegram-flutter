import 'package:coreui/coreui.dart';
import 'package:feature_chat_impl/src/tile/model/tile_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:tdlib/td_api.dart' as td;

class MessageTileMapper {
  ITileModel mapToTileModel(td.Message message) {
    final td.MessageContent content = message.content;
    switch (content.getConstructor()) {
      case td.MessageText.CONSTRUCTOR:
        {
          final td.MessageText m = message.content.cast();
          return MessageTextTileModel(
              id: message.id,
              isOutgoing: message.isOutgoing,
              text: TextSpan(text: m.text.text));
        }
      case td.MessageAnimation.CONSTRUCTOR:
        {
          final td.MessageAnimation m = message.content.cast();
          return MessageAnimationTileModel(
              id: message.id,
              isOutgoing: message.isOutgoing,
              type:
                  'not implemented ${message.content.runtimeType.toString()}');
        }
      case td.MessageAudio.CONSTRUCTOR:
        {
          final td.MessageAudio m = message.content.cast();
          return MessageAnimationTileModel(
              id: message.id,
              isOutgoing: message.isOutgoing,
              type:
                  'not implemented ${message.content.runtimeType.toString()}');
        }
      case td.MessageDocument.CONSTRUCTOR:
        {
          final td.MessageDocument m = message.content.cast();
          return MessageDocumentTileModel(
              id: message.id,
              isOutgoing: message.isOutgoing,
              type:
                  'not implemented ${message.content.runtimeType.toString()}');
        }
      case td.MessagePhoto.CONSTRUCTOR:
        {
          final td.MessagePhoto m = message.content.cast();
          return MessagePhotoTileModel(
              id: message.id,
              isOutgoing: message.isOutgoing,
              type:
                  'not implemented ${message.content.runtimeType.toString()}');
        }
      case td.MessageExpiredPhoto.CONSTRUCTOR:
        {
          final td.MessageExpiredPhoto m = message.content.cast();
          return MessageExpiredPhotoTileModel(
              id: message.id,
              isOutgoing: message.isOutgoing,
              type:
                  'not implemented ${message.content.runtimeType.toString()}');
        }
      case td.MessageSticker.CONSTRUCTOR:
        {
          final td.MessageSticker m = message.content.cast();
          return MessageStickerTileModel(
              id: message.id,
              isOutgoing: message.isOutgoing,
              type:
                  'not implemented ${message.content.runtimeType.toString()}');
        }
      case td.MessageVideo.CONSTRUCTOR:
        {
          final td.MessageVideo m = message.content.cast();
          return MessageVideoTileModel(
              id: message.id,
              isOutgoing: message.isOutgoing,
              type:
                  'not implemented ${message.content.runtimeType.toString()}');
        }
    }

    return UnknownMessageTileModel(
        id: message.id,
        isOutgoing: message.isOutgoing,
        type: 'not implemented ${message.content.runtimeType.toString()}');
  }
}

extension ContentExtension on td.MessageContent {
  T cast<T extends td.MessageContent>() => this as T;
}
