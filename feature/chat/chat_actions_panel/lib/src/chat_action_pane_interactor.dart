import 'dart:async';

import 'package:chat_actions_panel/chat_actions_panel.dart';
import 'package:core_tdlib_api/core_tdlib_api.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tdlib/td_api.dart' as td;
import 'package:tuple/tuple.dart';

class ChatActionPanelInteractor implements IChatActionPanelInteractor {
  ChatActionPanelInteractor({
    required int chatId,
    required IChatRepository chatRepository,
    required ISuperGroupRepository superGroupRepository,
    required IBasicGroupRepository basicGroupRepository,
    required IChatUpdatesProvider chatUpdatesProvider,
    required ISuperGroupUpdatesProvider superGroupUpdatesProvider,
  })  : _chatId = chatId,
        _superGroupRepository = superGroupRepository,
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
  final IChatUpdatesProvider _chatUpdatesProvider;
  StreamSubscription<PanelState>? _subscription;

  final BehaviorSubject<PanelState> _stateSubject =
      BehaviorSubject<PanelState>.seeded(const PanelState.empty());

  @override
  Stream<PanelState> get panelStateStream => _stateSubject;

  @override
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
          return Stream<PanelState>.value(const PanelState.empty());
        },
        basicGroup: (td.ChatTypeBasicGroup value) {
          return Stream<PanelState>.value(const PanelState.empty());
        },
        supergroup: (td.ChatTypeSupergroup value) {
          return Stream<td.Supergroup>.fromFuture(
                  _superGroupRepository.getGroup(value.supergroupId))
              .flatMap((td.Supergroup group) => _supergroupState(chat, group));
        },
        secret: (td.ChatTypeSecret value) {
          return Stream<PanelState>.value(const PanelState.empty());
        },
      );
    });

    _subscription = stateStream.listen(_stateSubject.add);
  }

  Stream<PanelState> _supergroupState(td.Chat chat, td.Supergroup group) {
    final Stream<td.Supergroup> groupUpdates =
        _getSuperGroupUpdatesStream(group.id).startWith(group);

    final Stream<td.ChatNotificationSettings> notificationSettingsUpdates =
        _getNotificationSettingsUpdatesStream(chat.id)
            .startWith(chat.notificationSettings);

    final Stream<Tuple2<td.Supergroup, td.ChatNotificationSettings>>
        groupInfoUpdates = Rx.combineLatest2<
                td.Supergroup,
                td.ChatNotificationSettings,
                Tuple2<td.Supergroup, td.ChatNotificationSettings>>(
            groupUpdates, notificationSettingsUpdates, (td.Supergroup group,
                td.ChatNotificationSettings notificationSettings) {
      return Tuple2<td.Supergroup, td.ChatNotificationSettings>(
          group, notificationSettings);
    });

    return groupInfoUpdates.map(
      (Tuple2<td.Supergroup, td.ChatNotificationSettings> data) {
        final td.Supergroup group = data.item1;
        final td.ChatNotificationSettings notificationSettings = data.item2;

        return group.status.map(
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
        );
      },
    );
  }

  Stream<td.ChatNotificationSettings> _getNotificationSettingsUpdatesStream(
          int chatId) =>
      _chatUpdatesProvider.chatUpdates
          .whereType<td.UpdateChatNotificationSettings>()
          .where((td.UpdateChatNotificationSettings update) =>
              update.chatId == chatId)
          .map((td.UpdateChatNotificationSettings update) =>
              update.notificationSettings);

  Stream<td.Supergroup> _getSuperGroupUpdatesStream(int supergroupId) =>
      _superGroupUpdatesProvider.superGroupUpdates
          .where((td.UpdateSupergroup update) =>
              update.supergroup.id == supergroupId)
          .map((td.UpdateSupergroup update) => update.supergroup);
}
