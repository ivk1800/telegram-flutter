import 'package:flutter/cupertino.dart';

import 'base_message_tile_model.dart';

class MessageChatDeleteMemberTileModel extends BaseMessageTileModel {
  const MessageChatDeleteMemberTileModel({
    required int id,
    required bool isOutgoing,
    required this.title,
  }) : super(isOutgoing: isOutgoing, id: id);

  final InlineSpan title;
}
