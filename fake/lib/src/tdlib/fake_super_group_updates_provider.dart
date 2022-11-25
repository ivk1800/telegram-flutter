import 'package:core_tdlib_api/core_tdlib_api.dart';
import 'package:td_api/td_api.dart' as td;

class FakeSuperGroupUpdatesProvider implements ISuperGroupUpdatesProvider {
  const FakeSuperGroupUpdatesProvider();

  @override
  Stream<td.UpdateSupergroup> get superGroupUpdates =>
      const Stream<td.UpdateSupergroup>.empty();
}
