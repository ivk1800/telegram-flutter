import 'package:coreui/coreui.dart';
import 'package:feature_settings_search_impl/src/tile/model/search_result_tile_model.dart';
import 'package:flutter/material.dart';
import 'package:jugger/jugger.dart' as j;

class SearchResultTileAdapterDelegate
    implements IListAdapterDelegate<SearchResultTileModel> {
  @j.inject
  SearchResultTileAdapterDelegate({required ISearchResultTileListener listener})
      : _listener = listener;

  final ISearchResultTileListener _listener;

  @override
  Widget create(BuildContext context, SearchResultTileModel model) {
    return ListTile(
      onTap: () {
        _listener.onSearchResultTap(model.type);
      },
      title: Text(model.title),
      subtitle: model.subtitle != null ? Text(model.subtitle!) : null,
    );
  }
}

abstract class ISearchResultTileListener {
  void onSearchResultTap(SearchResultType type);
}
