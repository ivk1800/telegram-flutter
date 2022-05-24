import 'package:tdlib/td_api.dart' as td;

abstract class IChatFilterRepository {
  Stream<List<td.ChatFilterInfo>> get chatFiltersStream;
}
