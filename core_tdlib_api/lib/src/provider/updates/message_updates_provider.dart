import 'package:tdlib/td_api.dart' as td;

/// updates for messages list
abstract class IChatMessagesUpdatesProvider {
  Stream<td.Update> get chatMessageUpdates;
}
