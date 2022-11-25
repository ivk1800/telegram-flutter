import 'package:core_tdlib_api/core_tdlib_api.dart';
import 'package:td_api/td_api.dart' as td;

class FakeChatUpdatesProvider implements IChatUpdatesProvider {
  const FakeChatUpdatesProvider();

  @override
  Stream<td.Update> get chatUpdates => const Stream<td.Update>.empty();
}
