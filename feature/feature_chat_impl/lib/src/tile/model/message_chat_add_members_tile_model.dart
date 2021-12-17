import 'package:rich_text_format/rich_text_format.dart' as rt;

import 'base_message_tile_model.dart';

class MessageChatAddMembersTileModel extends BaseMessageTileModel {
  const MessageChatAddMembersTileModel({
    required int id,
    required bool isOutgoing,
    required this.title,
  }) : super(isOutgoing: isOutgoing, id: id);

  final rt.RichText title;
}
