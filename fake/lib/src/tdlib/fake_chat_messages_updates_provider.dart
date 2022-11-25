import 'package:core_tdlib_api/core_tdlib_api.dart';
import 'package:td_api/td_api.dart' as td;

class FakeChatMessagesUpdatesProvider implements IChatMessagesUpdatesProvider {
  const FakeChatMessagesUpdatesProvider();

  @override
  Stream<td.Update> get chatMessageUpdates => const Stream<td.Update>.empty();
}
