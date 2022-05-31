import 'base_message_tile_model.dart';

class MessageVenueTileModel extends BaseMessageTileModel {
  const MessageVenueTileModel({
    required super.id,
    required super.isOutgoing,
    required this.type,
  });

  final String type;
}
