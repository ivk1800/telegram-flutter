import 'base_message_tile_model.dart';

class MessageVideoChatStartedTileModel extends BaseMessageTileModel {
  const MessageVideoChatStartedTileModel({
    required super.id,
    required super.isOutgoing,
    required this.type,
  });

  final String type;
}
