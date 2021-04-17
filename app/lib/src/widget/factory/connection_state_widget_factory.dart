import 'package:core/core.dart';
import 'package:flutter/cupertino.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tdlib/td_api.dart' as td;
import 'package:jugger/jugger.dart' as j;

typedef ConnectionReadyWidgetFactory = Widget Function(BuildContext context);

class ConnectionStateWidgetFactory {
  @j.inject
  ConnectionStateWidgetFactory(
      {required IConnectionStateUpdatesProvider connectionStateUpdatesProvider})
      : _connectionStateUpdatesProvider = connectionStateUpdatesProvider {
    _connectionStateUpdatesProvider.connectionStateUpdates
        .listen((td.UpdateConnectionState event) {
      _connectionStateSubject.add(event.state);
    });
  }

  final BehaviorSubject<td.ConnectionState> _connectionStateSubject =
      BehaviorSubject<td.ConnectionState>.seeded(
          const td.ConnectionStateWaitingForNetwork());

  final IConnectionStateUpdatesProvider _connectionStateUpdatesProvider;

  Widget create(
      BuildContext context, ConnectionReadyWidgetFactory readyWidgetFactory) {
    return StreamBuilder<td.ConnectionState>(
      stream: _connectionStateSubject,
      builder:
          (BuildContext context, AsyncSnapshot<td.ConnectionState> snapshot) {
        final td.ConnectionState? state = snapshot.data;

        if (state != null &&
            state.getConstructor() == td.ConnectionStateReady.CONSTRUCTOR) {
          return readyWidgetFactory.call(context);
        }
        return Text(state.runtimeType.toString());
      },
    );
  }
}
