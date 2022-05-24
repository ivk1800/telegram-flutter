import 'package:core_tdlib_api/core_tdlib_api.dart';
import 'package:tdlib/td_api.dart' as td;

class FakeChatFilterRepository implements IChatFilterRepository {
  const FakeChatFilterRepository({
    this.chatFilters = const Stream<List<td.ChatFilterInfo>>.empty(),
  });

  final Stream<List<td.ChatFilterInfo>> chatFilters;

  @override
  Stream<List<td.ChatFilterInfo>> get chatFiltersStream => chatFilters;
}
