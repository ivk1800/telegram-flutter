import 'package:flutter/rendering.dart';

import 'base_message_tile_model.dart';

class MessageChatUpgradeToTileModel extends BaseMessageTileModel {
  const MessageChatUpgradeToTileModel({
    required int id,
    required bool isOutgoing,
    required this.title,
  }) : super(isOutgoing: isOutgoing, id: id);

  final InlineSpan title;
}
