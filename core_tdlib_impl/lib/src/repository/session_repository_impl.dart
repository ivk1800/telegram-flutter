import 'package:core_tdlib_api/core_tdlib_api.dart';
import 'package:tdlib/td_api.dart' as td;

class SessionRepositoryImpl implements ISessionRepository {
  SessionRepositoryImpl({
    required ITdFunctionExecutor functionExecutor,
  }) : _functionExecutor = functionExecutor;

  final ITdFunctionExecutor _functionExecutor;

  @override
  Stream<List<td.Session>> get activeSessions =>
      Stream<td.Sessions>.fromFuture(_functionExecutor.send<td.Sessions>(
        const td.GetActiveSessions(),
      )).map((td.Sessions event) => event.sessions);
}
