import 'base_message_tile_model.dart';

abstract class BaseConversationMessageTileModel extends BaseMessageTileModel {
  const BaseConversationMessageTileModel({
    required int id,
    required bool isOutgoing,
  }) : super(id: id, isOutgoing: isOutgoing);
}
