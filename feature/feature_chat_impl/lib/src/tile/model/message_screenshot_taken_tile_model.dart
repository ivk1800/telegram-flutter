import 'base_message_tile_model.dart';

class MessageScreenshotTakenTileModel extends BaseMessageTileModel {
  const MessageScreenshotTakenTileModel({
    required int id,
    required bool isOutgoing,
    required this.type,
  }) : super(isOutgoing: isOutgoing, id: id);

  final String type;
}
