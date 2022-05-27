import 'dart:async';

import 'package:core_tdlib_api/core_tdlib_api.dart';
import 'package:core_tdlib_impl/src/data_source/data_source.dart';
import 'package:tdlib/td_api.dart' as td;

class UserRepositoryImpl extends IUserRepository {
  UserRepositoryImpl({
    required UserDataSource dataSource,
  }) : _dataSource = dataSource;

  final UserDataSource _dataSource;

  @override
  Future<td.User> getUser(int id) {
    return _dataSource.getUser(id);
    /*
    return _cache.putIfAbsent(
      id,
      () => _functionExecutor.send<td.User>(td.GetUser(userId: id)),
    );
     */
  }

  @override
  Future<td.UserFullInfo> getUserFullInfo(int id) =>
      _dataSource.getUserFullInfo(id);

  @override
  Stream<td.User> getUserAsStream(int id) => _dataSource.getUserAsStream(id);

  void dispose() {
    _dataSource.dispose();
  }
}
