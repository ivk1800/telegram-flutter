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

  Stream<T> sendFunction<T extends td.TdObject>(td.TdFunction event) {
    return Stream.fromFuture(clientSend(event)).flatMap((value) => events
        .where((td.TdObject element) {
          return element is T;
        })
        .take(1)
        .map((td.TdObject event) => event as T));
  }
}
