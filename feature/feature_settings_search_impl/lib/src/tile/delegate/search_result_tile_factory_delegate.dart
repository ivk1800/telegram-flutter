import 'package:feature_settings_search_impl/src/domain/search_item.dart';
import 'package:feature_settings_search_impl/src/tile/model/search_result_tile_model.dart';
import 'package:flutter/material.dart';
import 'package:tile/tile.dart';

abstract class ISearchResultTapListener {
  void onSearchResultTap(SearchItem item);
}

class SearchResultTileFactoryDelegate
    implements ITileFactoryDelegate<SearchResultTileModel> {
  SearchResultTileFactoryDelegate({
    required ISearchResultTapListener listener,
  }) : _listener = listener;

  final ISearchResultTapListener _listener;

  @override
  Widget create(BuildContext context, SearchResultTileModel model) {
    final String? subtitle = model.subtitle;
    return ListTile(
      onTap: () => _listener.onSearchResultTap(model.item),
      title: Text(model.title),
      subtitle: subtitle != null ? Text(subtitle) : null,
    );
  }
}
