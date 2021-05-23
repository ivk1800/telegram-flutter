import 'package:coreui/coreui.dart';
import 'package:feature_settings_search_impl/src/tile/model/faq_result_tile_model.dart';
import 'package:flutter/material.dart';
import 'package:jugger/jugger.dart' as j;

class FaqResultTileAdapterDelegate
    implements IListAdapterDelegate<FaqResultTileModel> {
  @j.inject
  FaqResultTileAdapterDelegate({required IFaqResultTileListener listener})
      : _listener = listener;

  final IFaqResultTileListener _listener;

  @override
  Widget create(BuildContext context, FaqResultTileModel model) {
    return ListTile(
      onTap: () {
        _listener.onFaqResultTap(model.url);
      },
      title: Text(model.title),
      subtitle: Text(model.subtitle),
    );
  }
}

abstract class IFaqResultTileListener {
  void onFaqResultTap(String url);
}
