import 'package:tdlib/td_api.dart' as td;
import 'package:td_client/td_client.dart';
import 'package:jugger/jugger.dart' as j;

import 'chat_updates_provider.dart';

class UpdatesProvider implements IChatUpdatesProvider {
  @j.inject
  UpdatesProvider({required TdClient client}) : _client = client;

  final TdClient _client;

  @override
  Stream<td.Update> get chatUpdates => _client.events.filterChatUpdates();
}

extension Sd on Stream<td.TdObject> {
  Stream<td.Update> filterChatUpdates() => where((td.TdObject event) =>
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
