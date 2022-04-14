import 'package:core_tdlib_api/core_tdlib_api.dart';
import 'package:tdlib/td_api.dart' as td;

class FakeConnectionStateProvider implements IConnectionStateProvider {
  const FakeConnectionStateProvider();
  @override
  Stream<td.ConnectionState> get connectionStateAsStream =>
      Stream<td.ConnectionState>.value(const td.ConnectionStateReady());
}
