import 'package:core/core.dart';
import 'package:tdlib/td_api.dart' as td;
import 'package:td_client/td_client.dart';
import 'package:jugger/jugger.dart' as j;

import 'chat_updates_provider.dart';

class UpdatesProvider
    implements
        IChatUpdatesProvider,
        IConnectionStateUpdatesProvider,
        IChatFiltersUpdatesProvider {
  @j.inject
  UpdatesProvider({required TdClient client}) : _client = client;

  final TdClient _client;

  @override
  Stream<td.Update> get chatUpdates => _client.events.chatUpdatesFilter();

  @override
  Stream<td.UpdateConnectionState> get connectionStateUpdates =>
      _client.events.connectionStateUpdatesFilter();

  @override
  Stream<td.UpdateChatFilters> get chatFiltersUpdates =>
      _client.events.chatFiltersUpdatesFilter();
}

extension _UpdatesExtensions on Stream<td.TdObject> {
  Stream<td.UpdateChatFilters> chatFiltersUpdatesFilter() =>
      where((td.TdObject event) => event is td.UpdateChatFilters)
          .cast<td.UpdateChatFilters>();

  Stream<td.UpdateConnectionState> connectionStateUpdatesFilter() =>
      where((td.TdObject event) => event is td.UpdateConnectionState)
          .cast<td.UpdateConnectionState>();

  Stream<td.Update> chatUpdatesFilter() => where((td.TdObject event) =>
      event is td.UpdateNewChat ||
      event is td.UpdateChatTitle ||
      event is td.UpdateChatPhoto ||
      event is td.UpdateChatPermissions ||
      event is td.UpdateChatLastMessage ||
      event is td.UpdateChatPosition ||
      event is td.UpdateChatIsMarkedAsUnread ||
      event is td.UpdateChatIsBlocked ||
      event is td.UpdateChatHasScheduledMessages ||
      event is td.UpdateChatVoiceChat ||
      event is td.UpdateChatDefaultDisableNotification ||
      event is td.UpdateChatReadInbox ||
      event is td.UpdateChatReadOutbox ||
      event is td.UpdateChatUnreadMentionCount ||
      event is td.UpdateChatNotificationSettings ||
      event is td.UpdateScopeNotificationSettings ||
      event is td.UpdateChatMessageTtlSetting ||
      event is td.UpdateChatActionBar ||
      event is td.UpdateChatReplyMarkup ||
      event is td.UpdateChatDraftMessage ||
      event is td.UpdateChatFilters ||
      event is td.UpdateChatOnlineMemberCount).cast<td.Update>();
}
