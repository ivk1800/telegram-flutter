import 'base_message_tile_model.dart';

class MessageAnimatedEmojiTileModel extends BaseMessageTileModel {
  const MessageAnimatedEmojiTileModel({
    required super.id,
    required super.isOutgoing,
    required this.type,
  });

  final String type;
}
