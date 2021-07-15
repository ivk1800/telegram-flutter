import 'package:flutter/rendering.dart';

import 'base_message_tile_model.dart';

class MessageChatAddMembersTileModel extends BaseMessageTileModel {
  const MessageChatAddMembersTileModel({
    required int id,
    required bool isOutgoing,
    required this.title,
  }) : super(isOutgoing: isOutgoing, id: id);

  final TextSpan title;
}
