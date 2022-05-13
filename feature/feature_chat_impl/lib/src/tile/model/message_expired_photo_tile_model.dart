import 'base_message_tile_model.dart';

class MessageExpiredPhotoTileModel extends BaseMessageTileModel {
  const MessageExpiredPhotoTileModel({
    required super.id,
    required super.isOutgoing,
    required this.type,
  });

  final String type;
}
