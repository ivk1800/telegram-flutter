import 'package:tdlib/td_api.dart' as td;

abstract class IConnectionStateProvider {
  Stream<td.ConnectionState> get connectionStateAsStream;
}
