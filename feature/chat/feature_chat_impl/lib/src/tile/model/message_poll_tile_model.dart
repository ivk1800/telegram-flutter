import 'base_message_tile_model.dart';

class MessagePollTileModel extends BaseMessageTileModel {
  const MessagePollTileModel({
    required super.id,
    required super.isOutgoing,
    required this.type,
  });

  final String type;
}
