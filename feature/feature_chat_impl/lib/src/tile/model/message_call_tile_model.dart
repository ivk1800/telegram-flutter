import 'package:feature_chat_impl/src/tile/model/base_conversation_message_tile_model.dart';

class MessageCallTileModel extends BaseConversationMessageTileModel {
  const MessageCallTileModel({
    required int id,
    required bool isOutgoing,
    required this.duration,
    required this.title,
    required this.date,
  }) : super(isOutgoing: isOutgoing, id: id);

  final String? duration;
  final String title;
  final String date;
}
