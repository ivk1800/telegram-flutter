import 'package:flutter/painting.dart';
import 'package:coreui/coreui.dart';

import 'base_message_tile_model.dart';

class MessagePhotoTileModel extends BaseMessageTileModel {
  const MessagePhotoTileModel({
    required int id,
    required bool isOutgoing,
    required this.type,
  }) : super(isOutgoing: isOutgoing, id: id);

  final String type;
}
