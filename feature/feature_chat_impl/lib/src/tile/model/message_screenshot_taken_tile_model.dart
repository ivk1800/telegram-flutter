import 'base_message_tile_model.dart';

class MessageScreenshotTakenTileModel extends BaseMessageTileModel {
  const MessageScreenshotTakenTileModel({
    required super.id,
    required super.isOutgoing,
    required this.type,
  });

  final String type;
}
