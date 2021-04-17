import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:presentation/presentation.dart';
import 'package:tdlib/td_api.dart' as td;
import 'package:jugger/jugger.dart' as j;

class SessionTileFactory {
  @j.inject
  SessionTileFactory();

  Widget create(BuildContext context, td.Session session) {
    return ListTile(
      onTap: () {},
      isThreeLine: true,
      trailing: session.isCurrent
          ? Text(
              'online',
              style: TextStyle(color: Theme.of(context).accentColor),
            )
          : null,
      title: Text('${session.applicationName} ${session.applicationVersion}'),
      subtitle: Text(
          '${session.deviceModel}, ${session.platform} ${session.systemVersion}, (${session.apiId}) \n${session.ip} - ${session.country}'),
    );
  }
}
