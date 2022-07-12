import 'package:td_api/td_api.dart' as td;

abstract class ISuperGroupUpdatesProvider {
  Stream<td.UpdateSupergroup> get superGroupUpdates;
}
