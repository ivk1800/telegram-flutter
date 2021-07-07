import 'base_message_tile_model.dart';

class MessageLocationTileModel extends BaseMessageTileModel {
  const MessageLocationTileModel({
    required int id,
    required bool isOutgoing,
    required this.type,
  }) : super(isOutgoing: isOutgoing, id: id);

  final String type;
}
