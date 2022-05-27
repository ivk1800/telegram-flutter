import 'package:core_tdlib_api/core_tdlib_api.dart';
import 'package:tdlib/td_api.dart' as td;

class SessionDataSource {
  SessionDataSource({
    required ITdFunctionExecutor functionExecutor,
  }) : _functionExecutor = functionExecutor;

  final ITdFunctionExecutor _functionExecutor;

  Future<List<td.Session>> get activeSessions => _functionExecutor
      .send<td.Sessions>(
        const td.GetActiveSessions(),
      )
      .then((td.Sessions value) => value.sessions);
}
