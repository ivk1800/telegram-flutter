import 'package:feature_chat_impl/src/util/minithumbnail.dart';
import 'package:flutter/rendering.dart';

import 'base_message_tile_model.dart';

class MessagePhotoTileModel extends BaseMessageTileModel {
  const MessagePhotoTileModel({
    required int id,
    required bool isOutgoing,
    required this.minithumbnail,
    required this.caption,
  }) : super(isOutgoing: isOutgoing, id: id);

  final Minithumbnail? minithumbnail;
  final InlineSpan? caption;
}
