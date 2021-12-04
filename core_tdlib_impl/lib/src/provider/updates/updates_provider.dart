import 'package:core_tdlib_api/core_tdlib_api.dart';
import 'package:td_client/td_client.dart';
import 'package:tdlib/td_api.dart' as td;

class UpdatesProvider
    implements
        IChatUpdatesProvider,
        IChatFiltersUpdatesProvider,
        IFileUpdatesProvider,
        IAuthenticationStateUpdatesProvider {
  UpdatesProvider({
    required TdClient client,
  }) : _client = client;

  final TdClient _client;

  @override
  Stream<td.Update> get chatUpdates => _client.events.chatUpdatesFilter();

  Stream<td.UpdateConnectionState> get connectionStateUpdates =>
      _client.events.connectionStateUpdatesFilter();

  @override
  Stream<td.UpdateChatFilters> get chatFiltersUpdates =>
      _client.events.chatFiltersUpdatesFilter();

  @override
  Stream<td.UpdateAuthorizationState> get authorizationStateUpdates =>
      _client.events.authorizationStateUpdatesFilter();

  @override
  Stream<td.UpdateFile> get fileUpdates => _client.events.fileUpdatesFilter();
}

extension _UpdatesExtensions on Stream<td.TdObject> {
  Stream<td.UpdateChatFilters> chatFiltersUpdatesFilter() =>
      where((td.TdObject event) => event is td.UpdateChatFilters)
          .cast<td.UpdateChatFilters>();

  Stream<td.UpdateConnectionState> connectionStateUpdatesFilter() =>
      where((td.TdObject event) => event is td.UpdateConnectionState)
          .cast<td.UpdateConnectionState>();

  Stream<td.UpdateAuthorizationState> authorizationStateUpdatesFilter() =>
      where((td.TdObject event) => event is td.UpdateAuthorizationState)
          .cast<td.UpdateAuthorizationState>();

  Stream<td.UpdateFile> fileUpdatesFilter() =>
      where((td.TdObject event) => event is td.UpdateFile)
          .cast<td.UpdateFile>();

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
