import 'package:core_tdlib_api/core_tdlib_api.dart';
import 'package:td_api/td_api.dart' as td;

class UserInfoResolver {
  UserInfoResolver({
    required IUserRepository userRepository,
  }) : _userRepository = userRepository;

  final IUserRepository _userRepository;

  Stream<UserInfo> resolveAsStream(int userId) {
    return _userRepository.getUserAsStream(userId).map(_mapToUserInfo);
  }

  Future<UserInfo> resolveAsFuture(int userId) => _resolve(userId);

  Future<UserInfo> _resolve(int userId) async {
    final td.User user = await _userRepository.getUser(userId);
    return _mapToUserInfo(user);
  }

  UserInfo _mapToUserInfo(td.User user) {
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
