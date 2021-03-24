import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:presentation/src/widget/widget.dart';
import 'package:tdlib/td_api.dart' as td;
import 'package:jugger/jugger.dart' as j;

typedef ChatTapCallback = void Function(td.Chat chat);

class ChatTileFactory {
  @j.inject
  ChatTileFactory();

  Widget create(BuildContext context, td.Chat chat, ChatTapCallback onTap) {
    return ListTile(
      onTap: () => onTap.call(chat),
      leading: TdAvatar(image: chat.photo?.small,),
      title: Text(chat.title),
      subtitle: Text(chat.lastMessage?.toString() ?? ''),
    );
  }
}
