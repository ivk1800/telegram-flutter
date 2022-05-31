import 'base_message_tile_model.dart';

class MessagePassportDataReceivedTileModel extends BaseMessageTileModel {
  const MessagePassportDataReceivedTileModel({
    required super.id,
    required super.isOutgoing,
    required this.type,
  });

  final String type;
}
