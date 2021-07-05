import 'package:coreui/coreui.dart';
import 'package:feature_settings_search_impl/src/tile/model/faq_result_tile_model.dart';
import 'package:flutter/material.dart';
import 'package:jugger/jugger.dart' as j;

typedef FaqResultTapCallback = void Function(BuildContext context, String url);

class FaqResultTileFactoryDelegate
    implements ITileFactoryDelegate<FaqResultTileModel> {
  @j.inject
  FaqResultTileFactoryDelegate({required FaqResultTapCallback tap})
      : _tap = tap;

  final FaqResultTapCallback _tap;

  @override
  Widget create(BuildContext context, FaqResultTileModel model) {
    return ListTile(
      onTap: () => _tap(context, model.url),
      title: Text(model.title),
      subtitle: Text(model.subtitle),
    );
  }
}
