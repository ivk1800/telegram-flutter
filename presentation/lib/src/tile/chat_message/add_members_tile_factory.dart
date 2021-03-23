import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:tdlib/td_api.dart' as td;
import 'package:jugger/jugger.dart' as j;

class AddMembersTileFactory {
  @j.inject
  AddMembersTileFactory();

  Widget create(BuildContext context, td.Message message,
      td.MessageChatAddMembers content) {
    return const Card(
      child: ListTile(title: Text('AddMembers')),
    );
  }
}
