import 'base_message_tile_model.dart';

class MessagePaymentSuccessfulBotTileModel extends BaseMessageTileModel {
  const MessagePaymentSuccessfulBotTileModel({
    required super.id,
    required super.isOutgoing,
    required this.type,
  });

  final String type;
}
