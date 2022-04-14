import 'package:core_tdlib_api/core_tdlib_api.dart';
import 'package:tdlib/td_api.dart' as td;

class UserInfoResolver {
  UserInfoResolver({
    required IUserRepository userRepository,
  }) : _userRepository = userRepository;

  final IUserRepository _userRepository;

  Stream<UserInfo> resolveAsStream(int userId) {
    return Stream<UserInfo>.fromFuture(_resolve(userId));
  }

  Future<UserInfo> _resolve(int userId) async {
    final td.User user = await _userRepository.getUser(userId);
    return UserInfo(
      user: user,
      statusHumanString: user.status.toString(),
    );
  }
}

class UserInfo {
  const UserInfo({
    required this.user,
    required this.statusHumanString,
  });

  final td.User user;

  final String statusHumanString;
}
