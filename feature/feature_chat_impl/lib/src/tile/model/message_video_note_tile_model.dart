import 'base_message_tile_model.dart';

class MessageVideoNoteTileModel extends BaseMessageTileModel {
  const MessageVideoNoteTileModel({
    required int id,
    required bool isOutgoing,
    required this.type,
  }) : super(isOutgoing: isOutgoing, id: id);

  final String type;
}
