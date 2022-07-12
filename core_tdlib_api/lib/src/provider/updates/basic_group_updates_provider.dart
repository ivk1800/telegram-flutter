import 'package:td_api/td_api.dart' as td;

abstract class IBasicGroupUpdatesProvider {
  Stream<td.UpdateBasicGroup> get basicGroupUpdates;
}
