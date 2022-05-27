import 'package:tdlib/td_api.dart' as td;

abstract class ISessionRepository {
  Future<List<td.Session>> get activeSessions;
}
