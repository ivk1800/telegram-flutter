import 'package:rich_text_format/rich_text_format.dart' as rt;

import 'base_message_tile_model.dart';

class MessageChatAddMembersTileModel extends BaseMessageTileModel {
  const MessageChatAddMembersTileModel({
    required super.id,
    required super.isOutgoing,
    required this.title,
  });

  final rt.RichText title;
}
