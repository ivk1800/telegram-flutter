import 'package:td_api/td_api.dart' as td;

abstract class IChatFiltersUpdatesProvider {
  Stream<td.UpdateChatFilters> get chatFiltersUpdates;
}
