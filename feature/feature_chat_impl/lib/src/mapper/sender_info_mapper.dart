import 'package:core_tdlib_api/core_tdlib_api.dart';
import 'package:feature_chat_impl/src/tile/model/base_conversation_message_tile_model.dart';
import 'package:tdlib/td_api.dart' as td;

class SenderInfoMapper {
  SenderInfoMapper({
    required IUserRepository userRepository,
    required IChatRepository chatRepository,
  })  : _userRepository = userRepository,
        _chatRepository = chatRepository;
  final IUserRepository _userRepository;

  final IChatRepository _chatRepository;

  Future<SenderInfo> map(td.MessageSender sender) async {
    switch (sender.getConstructor()) {
      case td.MessageSenderUser.CONSTRUCTOR:
        {
          final td.User user = await _userRepository
              .getUser((sender as td.MessageSenderUser).userId);
          return SenderInfo(
            id: user.id,
            senderName: '${user.firstName} ${user.lastName}',
            senderPhotoId: user.profilePhoto?.small.id,
          );
        }
      case td.MessageSenderChat.CONSTRUCTOR:
        {
          final td.Chat chat = await _chatRepository
              .getChat((sender as td.MessageSenderChat).chatId);
          return SenderInfo(
            id: chat.id,
            senderName: chat.title,
            senderPhotoId: chat.photo?.small.id,
          );
        }
    }

    throw Exception('unknown sender ${sender.runtimeType}');
  }
}
