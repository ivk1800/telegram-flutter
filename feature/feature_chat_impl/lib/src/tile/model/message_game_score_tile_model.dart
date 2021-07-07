import 'base_message_tile_model.dart';

class MessageGameScoreTileModel extends BaseMessageTileModel {
  const MessageGameScoreTileModel({
    required int id,
    required bool isOutgoing,
    required this.type,
  }) : super(isOutgoing: isOutgoing, id: id);

  final String type;
}
