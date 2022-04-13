import 'package:core_tdlib_api/core_tdlib_api.dart';
import 'package:tdlib/td_api.dart' as td;

class UserInfoResolver {
  UserInfoResolver({
    required IUserRepository userRepository,
  }) : _userRepository = userRepository;

  final IUserRepository _userRepository;

  Stream<UserInfo> resolveAsStream(int chatId) {
    return Stream<UserInfo>.fromFuture(_resolve(chatId));
  }

  Future<UserInfo> _resolve(int userId) async {
    final td.User user = await _userRepository.getUser(userId);
    return UserInfo(
      isContact: user.isContact,
    );
  }
}

class UserInfo {
  const UserInfo({
    required this.isContact,
  });

  final bool isContact;
}
