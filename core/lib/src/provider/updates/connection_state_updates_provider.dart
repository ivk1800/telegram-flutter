import 'package:tdlib/td_api.dart' as td;

abstract class IConnectionStateUpdatesProvider {
  Stream<td.UpdateConnectionState> get connectionStateUpdates;
}
