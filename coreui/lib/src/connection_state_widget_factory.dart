import 'package:core_tdlib_api/core_tdlib_api.dart';
import 'package:flutter/cupertino.dart';
import 'package:tdlib/td_api.dart' as td;

typedef ConnectionReadyWidgetFactory = Widget Function(BuildContext context);

class ConnectionStateWidgetFactory {
  ConnectionStateWidgetFactory({
    required IConnectionStateProvider connectionStateProvider,
  }) : _connectionStateProvider = connectionStateProvider;

  final IConnectionStateProvider _connectionStateProvider;

  Widget create(
    BuildContext context,
    ConnectionReadyWidgetFactory readyWidgetFactory,
  ) {
    return StreamBuilder<td.ConnectionState>(
      stream: _connectionStateProvider.connectionStateAsStream,
      builder:
          (BuildContext context, AsyncSnapshot<td.ConnectionState> snapshot) {
        final td.ConnectionState? state = snapshot.data;

        if (state != null) {
          if (state.getConstructor() == td.ConnectionStateReady.constructor) {
            return readyWidgetFactory.call(context);
          } else {
            return Text(_getStateText(state) ?? '');
          }
        }
        return readyWidgetFactory.call(context);
      },
    );
  }

  String? _getStateText(td.ConnectionState state) {
    switch (state.getConstructor()) {
      case td.ConnectionStateUpdating.constructor:
        {
          return 'Updating';
        }
      case td.ConnectionStateConnecting.constructor:
        {
          return 'Connecting...';
        }
      case td.ConnectionStateConnectingToProxy.constructor:
        {
          return 'Connecting to proxy';
        }
      case td.ConnectionStateWaitingForNetwork.constructor:
        {
          return 'Waiting for network...';
        }
    }

    return null;
  }
}
