import 'base_message_tile_model.dart';

class MessageChatDeletePhotoTileModel extends BaseMessageTileModel {
  const MessageChatDeletePhotoTileModel({
    required int id,
    required bool isOutgoing,
    required this.type,
  }) : super(isOutgoing: isOutgoing, id: id);

  final String type;
}
