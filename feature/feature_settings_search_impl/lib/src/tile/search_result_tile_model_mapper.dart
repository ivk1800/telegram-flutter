import 'package:feature_settings_search_impl/src/domain/search_item_data.dart';
import 'package:jugger/jugger.dart' as j;
import 'package:tile/tile.dart';

import 'model/search_result_tile_model.dart';

class SearchResultTileModelMapper {
  @j.inject
  const SearchResultTileModelMapper();

  ITileModel mapToTileModel(SearchItemData searchItem) {
    final String subtitle = searchItem.paths.join(' > ');
    return SearchResultTileModel(
      item: searchItem.item,
      title: searchItem.name,
      subtitle: subtitle.isEmpty ? null : subtitle,
    );
  }
}
