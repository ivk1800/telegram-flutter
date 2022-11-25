import 'package:core_tdlib_api/core_tdlib_api.dart';
import 'package:td_api/td_api.dart' as td;

class FakeBasicGroupUpdatesProvider implements IBasicGroupUpdatesProvider {
  const FakeBasicGroupUpdatesProvider();

  @override
  Stream<td.UpdateBasicGroup> get basicGroupUpdates =>
      const Stream<td.UpdateBasicGroup>.empty();
}
