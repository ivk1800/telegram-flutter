import 'package:td_api/td_api.dart' as td;

abstract class IEventsProvider {
  Stream<td.TdObject> get events;
}
