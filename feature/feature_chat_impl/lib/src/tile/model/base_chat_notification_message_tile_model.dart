import 'base_message_tile_model.dart';

abstract class BaseChatNotificationMessageTileModel
    extends BaseMessageTileModel {
  const BaseChatNotificationMessageTileModel({
    required int id,
  }) : super(id: id, isOutgoing: false);
}
