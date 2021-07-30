import 'package:tdlib/td_api.dart' as td;

abstract class IUserRepository {
  Future<td.User> getUser(int id);

  Future<td.UserFullInfo> getUserFullInfo(int id);
}
