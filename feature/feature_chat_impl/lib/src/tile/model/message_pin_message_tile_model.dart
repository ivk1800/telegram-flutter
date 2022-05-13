import 'base_message_tile_model.dart';

class MessagePinMessageTileModel extends BaseMessageTileModel {
  const MessagePinMessageTileModel({
    required super.id,
    required super.isOutgoing,
    required this.type,
  });

  final String type;
}
