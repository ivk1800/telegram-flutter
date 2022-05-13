import 'base_message_tile_model.dart';

class MessageExpiredVideoTileModel extends BaseMessageTileModel {
  const MessageExpiredVideoTileModel({
    required super.id,
    required super.isOutgoing,
    required this.type,
  });

  final String type;
}
