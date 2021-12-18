import 'package:tdlib/td_api.dart' as td;

abstract class ISuperGroupUpdatesProvider {
  Stream<td.UpdateSupergroup> get superGroupUpdates;
}
