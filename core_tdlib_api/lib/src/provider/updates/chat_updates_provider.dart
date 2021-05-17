import 'package:tdlib/td_api.dart' as td;

abstract class IChatUpdatesProvider {
  Stream<td.Update> get chatUpdates;
}
