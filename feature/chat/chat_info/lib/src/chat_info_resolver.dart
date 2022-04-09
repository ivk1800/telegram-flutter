import 'package:core_tdlib_api/core_tdlib_api.dart';
import 'package:tdlib/td_api.dart' as td;

class ChatInfoResolver {
  ChatInfoResolver({
    required ISuperGroupRepository superGroupRepository,
    required IChatRepository chatRepository,
    required IBasicGroupRepository basicGroupRepository,
  })  : _chatRepository = chatRepository,
        _superGroupRepository = superGroupRepository,
        _basicGroupRepository = basicGroupRepository;

  final IChatRepository _chatRepository;
  final IBasicGroupRepository _basicGroupRepository;
  final ISuperGroupRepository _superGroupRepository;

  Stream<ChatInfo> resolveAsStream(int chatId) {
    return Stream<ChatInfo>.fromFuture(_resolve(chatId));
  }

  Future<ChatInfo> _resolve(int chatId) async {
    final td.Chat chat = await _chatRepository.getChat(chatId);

    td.Supergroup? supergroup;
    td.BasicGroup? basicGroup;

    // todo use when extension
    switch (chat.type.getConstructor()) {
      case td.ChatTypeSecret.constructor:
      case td.ChatTypePrivate.constructor:
        {
          break;
        }
      case td.ChatTypeSupergroup.constructor:
        {
          supergroup = await _superGroupRepository
              .getGroup((chat.type as td.ChatTypeSupergroup).supergroupId);
          break;
        }
      case td.ChatTypeBasicGroup.constructor:
        {
          basicGroup = await _basicGroupRepository
              .getGroup((chat.type as td.ChatTypeBasicGroup).basicGroupId);
          break;
        }
    }

    return ChatInfo(
      isGroup: supergroup != null || basicGroup != null,
      isMember: (supergroup?.status.isMember ?? false) ||
          (basicGroup?.status.isMember ?? false),
      isChannel: supergroup?.isChannel ?? true,
      isCreator: (supergroup?.status.isCreator ?? false) ||
          (basicGroup?.status.isCreator ?? false),
      isAdmin: (supergroup?.status.isAdmin ?? false) ||
          (basicGroup?.status.isAdmin ?? false),
    );
  }
}

class ChatInfo {
  const ChatInfo({
    required this.isChannel,
    required this.isCreator,
    required this.isMember,
    required this.isGroup,
    required this.isAdmin,
  });

  final bool isChannel;
  final bool isGroup;
  final bool isCreator;
  final bool isMember;
  final bool isAdmin;
}

extension _ChatMemberStatusExt on td.ChatMemberStatus {
  bool get isCreator => this is td.ChatMemberStatusCreator;

  bool get isAdmin => this is td.ChatMemberStatusAdministrator;

  bool get isMember => this is td.ChatMemberStatusMember;
}
