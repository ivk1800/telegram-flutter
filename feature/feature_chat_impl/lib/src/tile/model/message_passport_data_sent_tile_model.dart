import 'base_message_tile_model.dart';

class MessagePassportDataSentTileModel extends BaseMessageTileModel {
  const MessagePassportDataSentTileModel({
    required super.id,
    required super.isOutgoing,
    required this.type,
  });

  final String type;
}
