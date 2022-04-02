import 'dart:async';

import 'package:core_tdlib_api/core_tdlib_api.dart';
import 'package:tdlib/td_api.dart' as td;
import 'package:username_generator/username_generator.dart';

import 'fake_user_provider.dart';

class FakeUserRepository implements IUserRepository {
  FakeUserRepository({required this.fakeUserProvider});

  final FakeUserProvider fakeUserProvider;

  final UsernameGenerator generator = UsernameGenerator();

  @override
  Future<td.User> getUser(int id) {
    return fakeUserProvider.getFakeUser().then((td.User value) {
      return value.copyWith(
        firstName: generator.generateRandom(),
        lastName: '',
      );
    });
  }

  @override
  Future<td.UserFullInfo> getUserFullInfo(int id) =>
      Completer<td.UserFullInfo>().future;
}
