import 'package:rich_text_format/rich_text_format.dart';

import 'base_message_tile_model.dart';

class MessageChatSetTtlTileModel extends BaseMessageTileModel {
  const MessageChatSetTtlTileModel({
    required int id,
    required bool isOutgoing,
    required this.title,
  }) : super(isOutgoing: isOutgoing, id: id);

  final RichText title;
}
