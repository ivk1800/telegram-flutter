import 'package:flutter/cupertino.dart';

import 'base_message_tile_model.dart';

class MessageChatUpgradeFromTileModel extends BaseMessageTileModel {
  const MessageChatUpgradeFromTileModel({
    required int id,
    required bool isOutgoing,
    required this.title,
  }) : super(isOutgoing: isOutgoing, id: id);

  final InlineSpan title;
}
