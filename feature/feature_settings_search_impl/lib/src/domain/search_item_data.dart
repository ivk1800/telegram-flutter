import 'package:feature_settings_search_impl/src/domain/search_group.dart';

import 'search_item.dart';

class SearchItemData {
  SearchItemData({
    required this.group,
    required this.item,
    required this.name,
    required this.paths,
  });

  final SearchGroup group;
  final SearchItem item;
  final String name;

  final List<String> paths;
}
