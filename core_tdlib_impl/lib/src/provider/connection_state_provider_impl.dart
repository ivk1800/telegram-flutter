import 'dart:async';

import 'package:core_tdlib_api/core_tdlib_api.dart';
import 'package:core_tdlib_impl/core_tdlib_impl.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tdlib/td_api.dart' as td;

class ConnectionStateProviderImpl implements IConnectionStateProvider {
  ConnectionStateProviderImpl({
    required UpdatesProvider updatesProvider,
  }) : _updatesProvider = updatesProvider {
    _init();
  }

  StreamSubscription<td.UpdateConnectionState>?
      _connectionStateUpdatesSubscription;

  void _init() {
    _connectionStateUpdatesSubscription = _updatesProvider
        .connectionStateUpdates
        .listen((td.UpdateConnectionState event) {
      _currentState = event.state;
    });
  }

  td.ConnectionState _currentState =
      const td.ConnectionStateWaitingForNetwork();

  final UpdatesProvider _updatesProvider;

  @override
  Stream<td.ConnectionState> get connectionStateAsStream =>
      _updatesProvider.connectionStateUpdates
          .map((td.UpdateConnectionState event) => event.state)
          .startWith(_currentState);

  void dispose() {
    _connectionStateUpdatesSubscription?.cancel();
  }
}
