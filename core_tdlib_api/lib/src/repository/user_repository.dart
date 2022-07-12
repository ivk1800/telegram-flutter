import 'package:td_api/td_api.dart' as td;

abstract class IUserRepository {
  Future<td.User> getUser(int id);

  Stream<td.User> getUserAsStream(int id);

  Future<td.UserFullInfo> getUserFullInfo(int id);
}
