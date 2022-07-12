import 'package:td_api/td_api.dart' as td;

abstract class IConnectionStateProvider {
  Stream<td.ConnectionState> get connectionStateAsStream;
}
