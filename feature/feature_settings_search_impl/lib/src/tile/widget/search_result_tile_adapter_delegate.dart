import 'package:coreui/coreui.dart';
import 'package:feature_settings_search_impl/src/tile/model/search_result_tile_model.dart';
import 'package:flutter/material.dart';
import 'package:jugger/jugger.dart' as j;

typedef SearchResultTapCallback = void Function(
    BuildContext context, SearchResultType type);

class SearchResultTileAdapterDelegate
    implements IListAdapterDelegate<SearchResultTileModel> {
  @j.inject
  SearchResultTileAdapterDelegate({required SearchResultTapCallback tap})
      : _tap = tap;

  final SearchResultTapCallback _tap;

  @override
  Widget create(BuildContext context, SearchResultTileModel model) {
    return ListTile(
      onTap: () => _tap(context, model.type),
      title: Text(model.title),
      subtitle: model.subtitle != null ? Text(model.subtitle!) : null,
    );
  }
}
