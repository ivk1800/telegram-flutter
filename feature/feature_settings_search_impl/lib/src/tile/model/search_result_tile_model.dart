import 'package:feature_settings_search_impl/src/domain/search_item.dart';
import 'package:tile/tile.dart';

class SearchResultTileModel implements ITileModel {
  const SearchResultTileModel({
    required this.title,
    required this.subtitle,
    required this.item,
  });

  final String title;
  final String? subtitle;

  final SearchItem item;
}
