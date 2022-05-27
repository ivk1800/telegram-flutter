import 'dart:async';

import 'package:core_tdlib_api/core_tdlib_api.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tdlib/td_api.dart' as td;

// TODO handle user updates and invalidate cache
class UserDataSource {
  UserDataSource({
    required ITdFunctionExecutor functionExecutor,
    required IUserUpdatesProvider userUpdatesProvider,
  })  : _functionExecutor = functionExecutor,
        _userUpdatesProvider = userUpdatesProvider {
    _init();
  }

  final ITdFunctionExecutor _functionExecutor;
  final IUserUpdatesProvider _userUpdatesProvider;
  StreamSubscription<td.User>? _userUpdatesSubscription;

  final Map<int, Future<td.User>> _cache = <int, Future<td.User>>{};

  Future<td.User> getUser(int id) {
    return _cache.putIfAbsent(
      id,
      () => _functionExecutor.send<td.User>(td.GetUser(userId: id)),
    );
  }

  Future<td.UserFullInfo> getUserFullInfo(int id) =>
      _functionExecutor.send<td.UserFullInfo>(td.GetUserFullInfo(userId: id));

  Stream<td.User> getUserAsStream(int id) {
    final Stream<td.User> updates = _userUpdatesProvider.userUpdates
        .where((td.UpdateUser event) => event.user.id == id)
        .map((td.UpdateUser event) => event.user);

    return Stream<td.User>.fromFuture(getUser(id))
        .concatWith(<Stream<td.User>>[updates]);
  }

  void dispose() {
    _userUpdatesSubscription?.cancel();
    _cache.clear();
  }

  void _init() {
    _userUpdatesSubscription = _userUpdatesProvider.userUpdates
        .map((td.UpdateUser event) => event.user)
        .listen((td.User user) {
      _cache[user.id] = Future<td.User>.value(user);
    });
  }
}
