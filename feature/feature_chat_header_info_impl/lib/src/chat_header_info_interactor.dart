import 'package:core_tdlib_api/core_tdlib_api.dart';
import 'package:feature_chat_header_info_api/feature_chat_header_info_api.dart';
import 'package:localization_api/localization_api.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tdlib/td_api.dart' as td;

class ChatHeaderInfoInteractor implements IChatHeaderInfoInteractor {
  ChatHeaderInfoInteractor({
    required int chatId,
    required IChatRepository chatRepository,
    required IUserRepository userRepository,
    required IBasicGroupRepository basicGroupRepository,
    required ISuperGroupRepository superGroupRepository,
    required ILocalizationManager localizationManager,
  })  : _chatId = chatId,
        _chatRepository = chatRepository,
        _superGroupRepository = superGroupRepository,
        _basicGroupRepository = basicGroupRepository,
        _localizationManager = localizationManager,
        _userRepository = userRepository {
    _infoSubject.add(ChatHeaderInfo(
      title: 'chat',
      subtitle: '',
      photoId: null,
      chatId: chatId,
    ));
  }

  final int _chatId;
  final IChatRepository _chatRepository;
  final IUserRepository _userRepository;
  final IBasicGroupRepository _basicGroupRepository;
  final ISuperGroupRepository _superGroupRepository;
  final ILocalizationManager _localizationManager;

  final BehaviorSubject<ChatHeaderInfo> _infoSubject =
      BehaviorSubject<ChatHeaderInfo>();

  @override
  Stream<ChatHeaderInfo> get infoStream =>
      Stream<td.Chat>.fromFuture(_chatRepository.getChat(_chatId))
          .flatMap((td.Chat chat) {
        switch (chat.type.getConstructor()) {
          case td.ChatTypeSecret.constructor:
          case td.ChatTypePrivate.constructor:
            {
              return _asUser(chat.id, chat);
            }
          case td.ChatTypeSupergroup.constructor:
            {
              final td.ChatTypeSupergroup type =
                  chat.type as td.ChatTypeSupergroup;
              return _asSupergroup(type.supergroupId, chat);
            }
          case td.ChatTypeBasicGroup.constructor:
            {
              final td.ChatTypeBasicGroup type =
                  chat.type as td.ChatTypeBasicGroup;
              return _asBasicGroup(type.basicGroupId, chat);
            }
        }
        // todo preferred do not throw exception
        throw Exception('unknown chat type ${chat.type.runtimeType}');
      });

  @override
  // todo check is hasValue
  ChatHeaderInfo get current => _infoSubject.value;

  Stream<ChatHeaderInfo> _asBasicGroup(int id, td.Chat chat) {
    return Stream<td.BasicGroup>.fromFuture(_basicGroupRepository.getGroup(id))
        .flatMap((td.BasicGroup group) {
      return Stream<ChatHeaderInfo>.value(
        _createInfoForGroup(chat, group.memberCount, false),
      );
    });
  }

  Stream<ChatHeaderInfo> _asSupergroup(int id, td.Chat chat) {
    return Stream<td.Supergroup>.fromFuture(_superGroupRepository.getGroup(id))
        .flatMap((td.Supergroup group) {
      return Stream<ChatHeaderInfo>.value(
        _createInfoForGroup(chat, group.memberCount, group.isChannel),
      );
    });
  }

  Stream<ChatHeaderInfo> _asUser(int id, td.Chat chat) {
    return Stream<td.User>.fromFuture(_userRepository.getUser(id))
        .flatMap((td.User user) {
      switch (user.type.getConstructor()) {
        case td.UserTypeRegular.constructor:
          {
            return Stream<ChatHeaderInfo>.value(ChatHeaderInfo(
              photoId: chat.photo?.small.id,
              chatId: chat.id,
              title: chat.title,
              subtitle: statusToString(user.status),
            ));
          }
        case td.UserTypeUnknown.constructor:
        case td.UserTypeDeleted.constructor:
          {
            return Stream<ChatHeaderInfo>.value(ChatHeaderInfo(
              photoId: chat.photo?.small.id,
              chatId: chat.id,
              title: _getString('HiddenName'),
              // https://git.io/J483z
              subtitle: _getString('ALongTimeAgo'),
            ));
          }

        case td.UserTypeBot.constructor:
          {
            return Stream<ChatHeaderInfo>.value(ChatHeaderInfo(
              photoId: chat.photo?.small.id,
              chatId: chat.id,
              title: chat.title,
              subtitle: _getString('Bot'),
            ));
          }
      }
      // todo preferred do not throw exception
      throw Exception('unknown user type ${user.type.runtimeType}');
    });
  }

  String statusToString(td.UserStatus status) {
    // todo use map
    switch (status.getConstructor()) {
      case td.UserStatusEmpty.constructor:
        {
          return _getString('ALongTimeAgo');
        }
      case td.UserStatusOnline.constructor:
        {
          // todo handle expires value
          return _getString('Online');
        }
      case td.UserStatusOffline.constructor:
        {
          // todo implement last seen format https://git.io/J4877
          return 'last seen todo';
        }
      case td.UserStatusRecently.constructor:
        {
          return _getString('Lately');
        }
      case td.UserStatusLastWeek.constructor:
        {
          return _getString('WithinAWeek');
        }
      case td.UserStatusLastMonth.constructor:
        {
          return _getString('WithinAMonth');
        }
    }
    // todo preferred do not throw exception
    throw Exception('unknown user status ${status.runtimeType}');
  }

  ChatHeaderInfo _createInfoForGroup(
    td.Chat chat,
    int memberCount,
    bool isChannel,
  ) {
    // todo handle UpdateChatOnlineMemberCount
    return ChatHeaderInfo(
      photoId: chat.photo?.small.id,
      chatId: chat.id,
      title: chat.title,
      // todo implement plural
      subtitle: '${_localizationManager.getStringFormatted('Members', <dynamic>[
            memberCount,
          ])} ${isChannel ? '' : ', ${_localizationManager.getStringFormatted('OnlineCount', <dynamic>[
              'todo',
            ])}'} ',
    );
  }

  String _getString(String key) => _localizationManager.getString(key);
}
