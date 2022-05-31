import 'base_message_tile_model.dart';

abstract class BaseChatNotificationMessageTileModel
    extends BaseMessageTileModel {
  const BaseChatNotificationMessageTileModel({
    required super.id,
  }) : super(isOutgoing: false);
}
