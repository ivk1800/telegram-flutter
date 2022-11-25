import 'dart:async';

import 'package:core_tdlib_api/core_tdlib_api.dart';
import 'package:td_api/td_api.dart' as td;
import 'package:username_generator/username_generator.dart';

import 'fake_user_provider.dart';

class FakeUserRepository implements IUserRepository {
  FakeUserRepository({this.fakeUserProvider});

  final FakeUserProvider? fakeUserProvider;

  final UsernameGenerator generator = UsernameGenerator();

  @override
  Future<td.User> getUser(int id) =>
      fakeUserProvider?.getFakeUser().then((td.User value) {
        return value.copyWith(
          firstName: generator.generateRandom(),
          lastName: '',
        );
      }) ??
      Completer<td.User>().future;

  @override
  Future<td.UserFullInfo> getUserFullInfo(int id) =>
      Completer<td.UserFullInfo>().future;

  @override
  Stream<td.User> getUserAsStream(int id) =>
      Stream<td.User>.fromFuture(getUser(id));
}
