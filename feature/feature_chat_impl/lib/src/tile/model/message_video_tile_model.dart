import 'package:feature_chat_impl/src/util/minithumbnail.dart';

import 'base_message_tile_model.dart';

class MessageVideoTileModel extends BaseMessageTileModel {
  const MessageVideoTileModel({
    required int id,
    required bool isOutgoing,
    required this.minithumbnail,
  }) : super(isOutgoing: isOutgoing, id: id);

  final Minithumbnail? minithumbnail;
}
