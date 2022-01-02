import 'package:flutter/material.dart';
import 'package:tile/tile.dart';

import 'session_tile_model.dart';

abstract class ISessionTileListener {
  void onSessionTap(int id);
}

class SessionTileFactory implements ITileFactoryDelegate<SessionTileModel> {
  const SessionTileFactory({
    required ISessionTileListener listener,
  }) : _listener = listener;

  final ISessionTileListener _listener;

  @override
  Widget create(BuildContext context, SessionTileModel model) {
    return ListTile(
      onTap: model.isCurrent
          ? null
          : () {
              _listener.onSessionTap(model.id);
            },
      isThreeLine: true,
      trailing: model.isCurrent
          ? Text(
              'online',
              style: TextStyle(color: Theme.of(context).colorScheme.secondary),
            )
          : null,
      title: Text(model.title),
      subtitle: Text(model.subtitle),
    );
  }
}
