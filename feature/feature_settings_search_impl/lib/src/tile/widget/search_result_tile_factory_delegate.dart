import 'package:feature_settings_search_impl/src/tile/model/search_result_tile_model.dart';
import 'package:flutter/material.dart';
import 'package:jugger/jugger.dart' as j;
import 'package:tile/tile.dart';

typedef SearchResultTapCallback = void Function(
    BuildContext context, SearchResultType type);

class SearchResultTileFactoryDelegate
    implements ITileFactoryDelegate<SearchResultTileModel> {
  @j.inject
  SearchResultTileFactoryDelegate({required SearchResultTapCallback tap})
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
