import 'base_message_tile_model.dart';

class MessagePaymentSuccessfulBotTileModel extends BaseMessageTileModel {
  const MessagePaymentSuccessfulBotTileModel({
    required int id,
    required bool isOutgoing,
    required this.type,
  }) : super(isOutgoing: isOutgoing, id: id);

  final String type;
}
