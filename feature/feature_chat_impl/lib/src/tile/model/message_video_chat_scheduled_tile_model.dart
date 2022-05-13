import 'base_message_tile_model.dart';

class MessageVideoChatScheduledTileModel extends BaseMessageTileModel {
  const MessageVideoChatScheduledTileModel({
    required super.id,
    required super.isOutgoing,
    required this.type,
  });

  final String type;
}
