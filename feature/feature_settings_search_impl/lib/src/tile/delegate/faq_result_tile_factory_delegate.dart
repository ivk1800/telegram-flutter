import 'package:feature_settings_search_impl/src/tile/model/faq_result_tile_model.dart';
import 'package:flutter/material.dart';
import 'package:tile/tile.dart';

abstract class IFaqResultTapListener {
  void onFaqResultTap(String url);
}

class FaqResultTileFactoryDelegate
    implements ITileFactoryDelegate<FaqResultTileModel> {
  FaqResultTileFactoryDelegate({
    required IFaqResultTapListener listener,
  }) : _listener = listener;

  final IFaqResultTapListener _listener;

  @override
  Widget create(BuildContext context, FaqResultTileModel model) {
    return ListTile(
      onTap: () => _listener.onFaqResultTap(model.url),
      title: Text(model.title),
      subtitle: Text(model.subtitle),
    );
  }
}
