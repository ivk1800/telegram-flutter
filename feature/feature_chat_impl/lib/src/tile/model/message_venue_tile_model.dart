import 'base_message_tile_model.dart';

class MessageVenueTileModel extends BaseMessageTileModel {
  const MessageVenueTileModel({
    required int id,
    required bool isOutgoing,
    required this.type,
  }) : super(isOutgoing: isOutgoing, id: id);

  final String type;
}
