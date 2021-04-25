import 'package:tdlib/td_api.dart' as td;

abstract class IChatFiltersUpdatesProvider {
  Stream<td.UpdateChatFilters> get chatFiltersUpdates;
}
