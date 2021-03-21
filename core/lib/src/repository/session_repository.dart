import 'package:tdlib/td_api.dart' as td;

abstract class ISessionRepository {
  Stream<List<td.Session>> get activeSessions;
}
