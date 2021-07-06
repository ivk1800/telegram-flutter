import 'package:flutter/painting.dart';

import 'base_message_tile_model.dart';

class MessageTextTileModel extends BaseMessageTileModel {
  const MessageTextTileModel({
    required int id,
    required bool isOutgoing,
    required this.text,
  }) : super(isOutgoing: isOutgoing, id: id);

  final InlineSpan text;
}
