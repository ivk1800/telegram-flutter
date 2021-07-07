import 'base_message_tile_model.dart';

class MessageCallTileModel extends BaseMessageTileModel {
  const MessageCallTileModel({
    required int id,
    required bool isOutgoing,
    required this.type,
  }) : super(isOutgoing: isOutgoing, id: id);

  final String type;
}
