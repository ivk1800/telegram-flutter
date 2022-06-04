import 'package:flutter/foundation.dart';

import 'base_message_tile_model.dart';

@immutable
class MessageStickerTileModel extends BaseMessageTileModel {
  const MessageStickerTileModel({
    required super.id,
    required super.isOutgoing,
    required this.stickerFileId,
    required this.setId,
    required this.isAnimated,
  });

  final int stickerFileId;
  final int setId;
  final bool isAnimated;
}
