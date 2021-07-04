import 'package:core_tdlib_api/core_tdlib_api.dart';
import 'package:jugger/jugger.dart' as j;
import 'package:td_client/td_client.dart';
import 'package:tdlib/td_api.dart' as td;
import 'package:tdlib/td_client.dart';

// TODO handle user updates and invalidate cache
class UserRepositoryImpl extends IUserRepository {
  @j.inject
  UserRepositoryImpl(this._client);

  final TdClient _client;

  final Map<int, Future<td.User>> _cache = <int, Future<td.User>>{};

  @override
  Future<td.User> getUser(int id) {
    return _cache.putIfAbsent(
        id, () => _client.send<td.User>(td.GetUser(userId: id)));
  }
}
