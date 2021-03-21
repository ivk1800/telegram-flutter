import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:presentation/presentation.dart';
import 'package:tdlib/td_api.dart' as td;
import 'package:jugger/jugger.dart' as j;

class ChatTileFactory {
  @j.inject
  ChatTileFactory();

  Widget create(td.Chat chat) {
    return ListTile(
      onTap: () {
        appComponent.getNavigationRouter().toRootSettingsScreen();
      },
      title: Text(chat.title),
      subtitle: Text(chat.lastMessage?.toString() ?? ''),
    );
  }
}
