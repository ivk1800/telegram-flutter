import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:presentation/src/widget/widget.dart';
import 'package:tdlib/td_api.dart' as td;
import 'package:jugger/jugger.dart' as j;

typedef ChatTapCallback = void Function(td.Chat chat);

class ChatTileFactory {
  @j.inject
  ChatTileFactory(this._avatarWidgetFactory);

  final AvatarWidgetFactory _avatarWidgetFactory;

  Widget create(BuildContext context, td.Chat chat, ChatTapCallback onTap) {
    return ListTile(
      onTap: () => onTap.call(chat),
      leading: _avatarWidgetFactory.create(context, chat.photo?.small.id),
      title: Text(chat.title),
      subtitle: Text(chat.lastMessage?.toString() ?? ''),
    );
  }
}
