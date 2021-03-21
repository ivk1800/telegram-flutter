import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:presentation/presentation.dart';
import 'package:tdlib/td_api.dart' as td;
import 'package:jugger/jugger.dart' as j;

class SessionTileFactory {
  @j.inject
  SessionTileFactory();

  Widget create(td.Session session) {
    return ListTile(
      isThreeLine: true,
      title: Text('${session.applicationName} ${session.applicationVersion}'),
      subtitle: Text(
          '${session.deviceModel}, ${session.platform} ${session.systemVersion}, (${session.apiId}) \n${session.ip} - ${session.country}'),
    );
  }
}
