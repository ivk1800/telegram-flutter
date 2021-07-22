import 'package:core_tdlib_api/core_tdlib_api.dart';
import 'package:tdlib/td_api.dart' as td;

class SenderNameResolver {
  SenderNameResolver(
      {required IUserRepository userRepository,
      required IChatRepository chatRepository})
      : _userRepository = userRepository,
        _chatRepository = chatRepository;
  final IUserRepository _userRepository;

  final IChatRepository _chatRepository;

  Future<String?> resolve(td.MessageSender sender) async {
    switch (sender.getConstructor()) {
      case td.MessageSenderUser.CONSTRUCTOR:
        {
          final td.User user = await _userRepository
              .getUser((sender as td.MessageSenderUser).userId);
          return '${user.firstName} ${user.lastName}';
        }
      case td.MessageSenderChat.CONSTRUCTOR:
        {
          final td.Chat chat = await _chatRepository
              .getChat((sender as td.MessageSenderChat).chatId);
          return chat.title;
        }
    }
    return null;
  }
}
