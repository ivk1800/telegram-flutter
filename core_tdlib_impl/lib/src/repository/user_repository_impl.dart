import 'package:core_tdlib_api/core_tdlib_api.dart';
import 'package:tdlib/td_api.dart' as td;

// TODO handle user updates and invalidate cache
class UserRepositoryImpl extends IUserRepository {
  UserRepositoryImpl({
    required ITdFunctionExecutor functionExecutor,
  }) : _functionExecutor = functionExecutor;

  final ITdFunctionExecutor _functionExecutor;

  final Map<int, Future<td.User>> _cache = <int, Future<td.User>>{};

  @override
  Future<td.User> getUser(int id) {
    return _cache.putIfAbsent(
        id, () => _functionExecutor.send<td.User>(td.GetUser(userId: id)));
  }

  @override
  Future<td.UserFullInfo> getUserFullInfo(int id) =>
      _functionExecutor.send<td.UserFullInfo>(td.GetUserFullInfo(userId: id));
}
