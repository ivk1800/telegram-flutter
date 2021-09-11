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

  Future<ChatInfo> resolve(int chatId) async {
    final td.Chat chat = await _chatRepository.getChat(chatId);

    td.Supergroup? supergroup;
    td.BasicGroup? basicGroup;

    switch (chat.type.getConstructor()) {
      case td.ChatTypeSecret.CONSTRUCTOR:
      case td.ChatTypePrivate.CONSTRUCTOR:
        {
          break;
        }
      case td.ChatTypeSupergroup.CONSTRUCTOR:
        {
          supergroup = await _superGroupRepository
              .getGroup((chat.type as td.ChatTypeSupergroup).supergroupId);
          break;
        }
      case td.ChatTypeBasicGroup.CONSTRUCTOR:
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
            (basicGroup?.status.isCreator ?? false));
  }
}

class ChatInfo {
  const ChatInfo({
    required this.isChannel,
    required this.isCreator,
    required this.isMember,
    required this.isGroup,
  });

  final bool isChannel;
  final bool isGroup;
  final bool isCreator;
  final bool isMember;
}

extension _ChatMemberStatusExt on td.ChatMemberStatus {
  bool get isCreator => this is td.ChatMemberStatusCreator;

  bool get isAdmin => this is td.ChatMemberStatusAdministrator;

  bool get isMember =>
      this is td.ChatMemberStatusMember || isAdmin || isCreator;
}
