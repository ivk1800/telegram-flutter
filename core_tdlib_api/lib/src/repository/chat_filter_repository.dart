import 'package:tdlib/td_api.dart' as td;

abstract class IChatFilterRepository {
  List<td.ChatFilterInfo> get chatFilters;
}
