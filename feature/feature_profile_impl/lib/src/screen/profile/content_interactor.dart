import 'package:core_tdlib_api/core_tdlib_api.dart';
import 'package:feature_profile_impl/src/screen/profile/profile_args.dart';
import 'package:feature_shared_media_api/feature_shared_media_api.dart';
import 'package:localization_api/localization_api.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tdlib/td_api.dart' as td;
import 'package:tuple/tuple.dart';

class ContentInteractor {
  ContentInteractor({
    required ProfileArgs args,
    required IUserRepository userRepository,
    required ILocalizationManager localizationManager,
    required IChatRepository chatRepository,
    required ISuperGroupRepository superGroupRepository,
    required IBasicGroupRepository basicGroupRepository,
    required IChatMessageRepository messageRepository,
  })  : _args = args,
        _userRepository = userRepository,
        _chatRepository = chatRepository,
        _localizationManager = localizationManager,
        _superGroupRepository = superGroupRepository,
        _basicGroupRepository = basicGroupRepository,
        _messageRepository = messageRepository;

  final BehaviorSubject<ContentData> _contentDataSubject =
      BehaviorSubject<ContentData>();

  final ProfileArgs _args;
  final IChatMessageRepository _messageRepository;
  final ISuperGroupRepository _superGroupRepository;
  final IBasicGroupRepository _basicGroupRepository;
  final IUserRepository _userRepository;
  final IChatRepository _chatRepository;
  final ILocalizationManager _localizationManager;

  Stream<ContentData> get content => _contentDataSubject;

  // todo handle Update*FullInfo events
  Future<ContentData> getContent() async {
    final List<SharedContentInfo> messagesInfo = (await _getMessagesCount())
        .where((Tuple2<SharedContentType, int> element) => element.item2 > 0)
        .map(
          (Tuple2<SharedContentType, int> e) => SharedContentInfo(
            title: _toHumanString(e.item1),
            type: e.item1,
            count: e.item2,
          ),
        )
        .toList();

    final td.Chat chat = await _chatRepository.getChat(_args.id);
    switch (chat.type.getConstructor()) {
      case td.ChatTypeSecret.CONSTRUCTOR:
        {
          return _getContentForUser(
            messagesInfo,
            await _userRepository
                .getUserFullInfo((chat.type as td.ChatTypeSecret).userId),
            chat,
          );
        }
      case td.ChatTypePrivate.CONSTRUCTOR:
        {
          return _getContentForUser(
            messagesInfo,
            await _userRepository
                .getUserFullInfo((chat.type as td.ChatTypePrivate).userId),
            chat,
          );
        }
      case td.ChatTypeBasicGroup.CONSTRUCTOR:
        {
          return _getContentForBasicGroup(
            messagesInfo,
            await _basicGroupRepository.getGroupFullInfo(
              (chat.type as td.ChatTypeBasicGroup).basicGroupId,
            ),
            chat,
          );
        }
      case td.ChatTypeSupergroup.CONSTRUCTOR:
        {
          return _getContentForSupergroup(
            messagesInfo,
            await _superGroupRepository.getGroupFullInfo(
              (chat.type as td.ChatTypeSupergroup).supergroupId,
            ),
            chat,
          );
        }
    }

    throw StateError('unknown chat type ${chat.type.runtimeType}');
  }

  Future<List<Tuple2<SharedContentType, int>>> _getMessagesCount() async {
    final List<Future<Tuple2<SharedContentType, int>>> countsFuture =
        <Future<Tuple2<SharedContentType, int>>>[
      _messageRepository
          .getMessagesCount(
            chatId: _args.id,
            filter: const td.SearchMessagesFilterPhotoAndVideo(),
          )
          .then((int value) =>
              Tuple2<SharedContentType, int>(SharedContentType.Media, value)),
      _messageRepository
          .getMessagesCount(
            chatId: _args.id,
            filter: const td.SearchMessagesFilterDocument(),
          )
          .then((int value) =>
              Tuple2<SharedContentType, int>(SharedContentType.Files, value)),
      _messageRepository
          .getMessagesCount(
            chatId: _args.id,
            filter: const td.SearchMessagesFilterUrl(),
          )
          .then((int value) =>
              Tuple2<SharedContentType, int>(SharedContentType.Links, value)),
      _messageRepository
          .getMessagesCount(
            chatId: _args.id,
            filter: const td.SearchMessagesFilterAudio(),
          )
          .then((int value) =>
              Tuple2<SharedContentType, int>(SharedContentType.Music, value)),
      _messageRepository
          .getMessagesCount(
            chatId: _args.id,
            filter: const td.SearchMessagesFilterVoiceNote(),
          )
          .then((int value) =>
              Tuple2<SharedContentType, int>(SharedContentType.Voice, value)),
      _messageRepository
          .getMessagesCount(
            chatId: _args.id,
            filter: const td.SearchMessagesFilterAnimation(),
          )
          .then((int value) =>
              Tuple2<SharedContentType, int>(SharedContentType.Gif, value)),
    ];

    return Future.wait(countsFuture);
  }

  Future<ContentData> _getContentForUser(
    List<SharedContentInfo> messagesInfo,
    td.UserFullInfo userFullInfo,
    td.Chat chat,
  ) async {
    return ContentData(
      description: userFullInfo.bio,
      sharedContent: messagesInfo,
      isMuted: chat.notificationSettings.muteFor > 0,
    );
  }

  Future<ContentData> _getContentForSupergroup(
    List<SharedContentInfo> messagesInfo,
    td.SupergroupFullInfo supergroupFullInfo,
    td.Chat chat,
  ) async {
    return ContentData(
      description: supergroupFullInfo.description,
      sharedContent: messagesInfo,
      isMuted: chat.notificationSettings.muteFor > 0,
    );
  }

  Future<ContentData> _getContentForBasicGroup(
    List<SharedContentInfo> messagesInfo,
    td.BasicGroupFullInfo basicGroupFullInfo,
    td.Chat chat,
  ) async {
    return ContentData(
      description: basicGroupFullInfo.description,
      sharedContent: messagesInfo,
      // todo extract extension
      isMuted: chat.notificationSettings.muteFor > 0,
    );
  }

  String _toHumanString(SharedContentType type) {
    switch (type) {
      case SharedContentType.Media:
        break;
      case SharedContentType.Files:
        break;
      case SharedContentType.Links:
        return _localizationManager.getString('SharedLinks');
      case SharedContentType.Music:
        break;
      case SharedContentType.Voice:
        break;
      case SharedContentType.Gif:
        break;
      case SharedContentType.Groups:
        break;
    }

    return type.toString().split('.')[1];
  }
}

class ContentData {
  ContentData({
    required this.sharedContent,
    required this.description,
    // todo handle UpdateChatNotificationSettings
    required this.isMuted,
  });

  final List<SharedContentInfo> sharedContent;

  final String description;
  final bool isMuted;
}

class SharedContentInfo {
  SharedContentInfo({
    required this.type,
    required this.count,
    required this.title,
  });

  final SharedContentType type;
  final int count;
  final String title;
}

extension ContentDataExt on ContentData {
  ContentData copy({
    bool? isMuted,
    String? description,
    List<SharedContentInfo>? sharedContent,
  }) {
    return ContentData(
      isMuted: isMuted ?? this.isMuted,
      description: description ?? this.description,
      sharedContent: sharedContent ?? this.sharedContent,
    );
  }
}
