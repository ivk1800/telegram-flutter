import 'base_message_tile_model.dart';

class MessageAnimationTileModel extends BaseMessageTileModel {
  const MessageAnimationTileModel({
    required int id,
    required bool isOutgoing,
    required this.type,
  }) : super(isOutgoing: isOutgoing, id: id);

  final String type;
}
