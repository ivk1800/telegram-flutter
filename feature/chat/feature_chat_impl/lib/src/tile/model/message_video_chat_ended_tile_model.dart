import 'base_message_tile_model.dart';

class MessageVideoChatEndedTileModel extends BaseMessageTileModel {
  const MessageVideoChatEndedTileModel({
    required super.id,
    required super.isOutgoing,
    required this.type,
  });

  final String type;
}
