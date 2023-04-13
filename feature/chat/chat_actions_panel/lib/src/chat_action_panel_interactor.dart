import 'dart:async';

import 'package:core_tdlib_api/core_tdlib_api.dart';
import 'package:rxdart/rxdart.dart';
import 'package:td_api/td_api.dart' as td;
import 'package:tuple/tuple.dart';

import 'panel_state.dart';

class ChatActionPanelInteractor {
  ChatActionPanelInteractor({
    required int chatId,
    required IChatRepository chatRepository,
    required IBasicGroupUpdatesProvider basicGroupUpdatesProvider,
    required ISuperGroupRepository superGroupRepository,
    required IBasicGroupRepository basicGroupRepository,
    required IChatUpdatesProvider chatUpdatesProvider,
    required ISuperGroupUpdatesProvider superGroupUpdatesProvider,
  })  : _chatId = chatId,
        _superGroupRepository = superGroupRepository,
        _basicGroupUpdatesProvider = basicGroupUpdatesProvider,
        _basicGroupRepository = basicGroupRepository,
        _chatUpdatesProvider = chatUpdatesProvider,
        _superGroupUpdatesProvider = superGroupUpdatesProvider,
        _chatRepository = chatRepository {
    _beginListen();
  }

  final int _chatId;
  final IChatRepository _chatRepository;
  final ISuperGroupRepository _superGroupRepository;
  final IBasicGroupRepository _basicGroupRepository;
  final ISuperGroupUpdatesProvider _superGroupUpdatesProvider;
  final IBasicGroupUpdatesProvider _basicGroupUpdatesProvider;
  final IChatUpdatesProvider _chatUpdatesProvider;
  StreamSubscription<PanelState>? _subscription;

  final BehaviorSubject<PanelState> _stateSubject =
      BehaviorSubject<PanelState>.seeded(const PanelState.empty());

  Stream<PanelState> get panelStateStream => _stateSubject;

  void dispose() {
    _stateSubject.close();
    _subscription?.cancel();
  }

  void _beginListen() {
    final Stream<PanelState> stateStream =
        Stream<td.Chat>.fromFuture(_chatRepository.getChat(_chatId))
            .flatMap((td.Chat chat) {
      return chat.type.map(
        private: (td.ChatTypePrivate value) {
          return _getPrivateChatState(chat);
        },
        basicGroup: (td.ChatTypeBasicGroup value) {
          return Stream<td.BasicGroup>.fromFuture(
            _basicGroupRepository.getGroup(value.basicGroupId),
          ).flatMap((td.BasicGroup group) => _basicGroupState(chat, group));
        },
        supergroup: (td.ChatTypeSupergroup value) {
          return Stream<td.Supergroup>.fromFuture(
            _superGroupRepository.getGroup(value.supergroupId),
          ).flatMap((td.Supergroup group) => _supergroupState(chat, group));
        },
        secret: (td.ChatTypeSecret value) {
          return Stream<PanelState>.value(const PanelState.empty());
        },
      );
    });

    _subscription = stateStream.listen(_stateSubject.add);
  }

  Stream<PanelState> _getPrivateChatState(td.Chat chat) {
    if (chat.permissions.canSendOtherMessages) {
      return Stream<PanelState>.value(const PanelState.writer());
    }

    return Stream<PanelState>.value(const PanelState.empty());
  }

  Stream<PanelState> _finalPanelState({
    required td.ChatMemberStatus status,
    required td.ChatNotificationSettings notificationSettings,
    required td.ChatPermissions permissions,
  }) {
    return Stream<PanelState>.value(
      status.map(
        creator: (td.ChatMemberStatusCreator value) {
          return const PanelState.empty();
        },
        administrator: (td.ChatMemberStatusAdministrator value) {
          return const PanelState.empty();
        },
        member: (td.ChatMemberStatusMember value) {
          return PanelState.channelSubscriber(
            isMuted: notificationSettings.muteFor > 0,
          );
        },
        restricted: (td.ChatMemberStatusRestricted value) {
          return const PanelState.empty();
        },
        left: (td.ChatMemberStatusLeft value) {
          return const PanelState.join();
        },
        banned: (td.ChatMemberStatusBanned value) {
          return const PanelState.empty();
        },
      ),
    );
  }

  Stream<PanelState> _supergroupState(td.Chat chat, td.Supergroup group) {
    final Stream<td.Supergroup> groupUpdates =
        _getSuperGroupUpdatesStream(group.id).startWith(group);

    final Stream<td.ChatNotificationSettings> notificationSettingsUpdates =
        _getNotificationSettingsUpdatesStream(chat.id)
            .startWith(chat.notificationSettings);

    final Stream<td.ChatPermissions> chatPermissionsUpdates =
        _getChatPermissionsUpdatesStream(chat.id).startWith(chat.permissions);

    final Stream<
        Tuple3<td.Supergroup, td.ChatNotificationSettings,
            td.ChatPermissions>> groupInfoUpdates = Rx.combineLatest3<
        td.Supergroup,
        td.ChatNotificationSettings,
        td.ChatPermissions,
        Tuple3<td.Supergroup, td.ChatNotificationSettings, td.ChatPermissions>>(
      groupUpdates,
      notificationSettingsUpdates,
      chatPermissionsUpdates,
      (
        td.Supergroup group,
        td.ChatNotificationSettings notificationSettings,
        td.ChatPermissions chatPermissions,
      ) {
        return Tuple3<td.Supergroup, td.ChatNotificationSettings,
            td.ChatPermissions>(
          group,
          notificationSettings,
          chatPermissions,
        );
      },
    );

    return groupInfoUpdates.flatMap(
      (
        Tuple3<td.Supergroup, td.ChatNotificationSettings, td.ChatPermissions>
            data,
      ) {
        final td.Supergroup group = data.item1;
        final td.ChatNotificationSettings notificationSettings = data.item2;
        final td.ChatPermissions permissions = data.item3;

        return _finalPanelState(
          status: group.status,
          notificationSettings: notificationSettings,
          permissions: permissions,
        );
      },
    );
  }

  Stream<PanelState> _basicGroupState(td.Chat chat, td.BasicGroup group) {
    final Stream<td.BasicGroup> groupUpdates =
        _getBasicGroupUpdatesStream(group.id).startWith(group);

    final Stream<td.ChatNotificationSettings> notificationSettingsUpdates =
        _getNotificationSettingsUpdatesStream(chat.id)
            .startWith(chat.notificationSettings);

    final Stream<td.ChatPermissions> chatPermissionsUpdates =
        _getChatPermissionsUpdatesStream(chat.id).startWith(chat.permissions);

    final Stream<
        Tuple3<td.BasicGroup, td.ChatNotificationSettings,
            td.ChatPermissions>> groupInfoUpdates = Rx.combineLatest3<
        td.BasicGroup,
        td.ChatNotificationSettings,
        td.ChatPermissions,
        Tuple3<td.BasicGroup, td.ChatNotificationSettings, td.ChatPermissions>>(
      groupUpdates,
      notificationSettingsUpdates,
      chatPermissionsUpdates,
      (
        td.BasicGroup group,
        td.ChatNotificationSettings notificationSettings,
        td.ChatPermissions chatPermissions,
      ) {
        return Tuple3<td.BasicGroup, td.ChatNotificationSettings,
            td.ChatPermissions>(
          group,
          notificationSettings,
          chatPermissions,
        );
      },
    );

    return groupInfoUpdates.flatMap(
      (
        Tuple3<td.BasicGroup, td.ChatNotificationSettings, td.ChatPermissions>
            data,
      ) {
        final td.BasicGroup group = data.item1;
        final td.ChatNotificationSettings notificationSettings = data.item2;
        final td.ChatPermissions permissions = data.item3;

        return _finalPanelState(
          status: group.status,
          notificationSettings: notificationSettings,
          permissions: permissions,
        );
      },
    );
  }

  Stream<td.ChatNotificationSettings> _getNotificationSettingsUpdatesStream(
    int chatId,
  ) =>
      _chatUpdatesProvider.chatUpdates
          .whereType<td.UpdateChatNotificationSettings>()
          .where(
            (td.UpdateChatNotificationSettings update) =>
                update.chatId == chatId,
          )
          .map(
            (td.UpdateChatNotificationSettings update) =>
                update.notificationSettings,
          );

  Stream<td.ChatPermissions> _getChatPermissionsUpdatesStream(
    int chatId,
  ) =>
      _chatUpdatesProvider.chatUpdates
          .whereType<td.UpdateChatPermissions>()
          .where((td.UpdateChatPermissions update) => update.chatId == chatId)
          .map((td.UpdateChatPermissions update) => update.permissions);

  Stream<td.Supergroup> _getSuperGroupUpdatesStream(int supergroupId) =>
      _superGroupUpdatesProvider.superGroupUpdates
          .where(
            (td.UpdateSupergroup update) =>
                update.supergroup.id == supergroupId,
          )
          .map((td.UpdateSupergroup update) => update.supergroup);

  Stream<td.BasicGroup> _getBasicGroupUpdatesStream(int basicGroupId) =>
      _basicGroupUpdatesProvider.basicGroupUpdates
          .where(
            (td.UpdateBasicGroup update) =>
                update.basicGroup.id == basicGroupId,
          )
          .map((td.UpdateBasicGroup update) => update.basicGroup);
}
