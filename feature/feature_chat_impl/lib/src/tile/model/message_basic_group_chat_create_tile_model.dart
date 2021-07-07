import 'base_message_tile_model.dart';

class MessageBasicGroupChatCreateTileModel extends BaseMessageTileModel {
  const MessageBasicGroupChatCreateTileModel({
    required int id,
    required bool isOutgoing,
    required this.type,
  }) : super(isOutgoing: isOutgoing, id: id);

  final String type;
}
