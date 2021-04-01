import 'package:jugger/jugger.dart' as j;
import 'package:core/core.dart';
import 'package:td_client/td_client.dart';
import 'package:tdlib/td_api.dart' as td;

class SessionRepositoryImpl implements ISessionRepository {
  @j.inject
  SessionRepositoryImpl(this.client);

  final TdClient client;

  @override
  Stream<List<td.Session>> get activeSessions => Stream<td.Sessions>.fromFuture(
          client.send<td.Sessions>(td.GetActiveSessions()))
      .map((td.Sessions event) => event.sessions);
}
