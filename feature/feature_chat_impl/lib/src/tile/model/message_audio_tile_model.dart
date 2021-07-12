import 'base_message_tile_model.dart';

class MessageAudioTileModel extends BaseMessageTileModel {
  const MessageAudioTileModel({
    required int id,
    required bool isOutgoing,
    required this.title,
    required this.performer,
    required this.totalDuration,
  }) : super(isOutgoing: isOutgoing, id: id);

  final String title;
  final String performer;
  final String totalDuration;
}
