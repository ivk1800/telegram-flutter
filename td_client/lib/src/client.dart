import 'dart:async';

import 'package:rxdart/rxdart.dart';
import 'package:tdlib/td_api.dart' as td;
import 'package:tdlib/td_client.dart' as tdc;

class TdClient {
  int clientId = 0;

  final PublishSubject<td.TdObject> _eventController =
      PublishSubject<td.TdObject>();

  Future<void> init() async {
    clientId = await tdc.TdClient.createClient();
    tdc.TdClient.clientEvents(clientId).listen((td.TdObject? event) {
      if (event != null) {
        _eventController.add(event);
      }
    });
  }

  Stream<td.TdObject> get events => _eventController.stream;

  Future<void> clientSend(td.TdFunction event) =>
      tdc.TdClient.clientSend(clientId, event);
}
