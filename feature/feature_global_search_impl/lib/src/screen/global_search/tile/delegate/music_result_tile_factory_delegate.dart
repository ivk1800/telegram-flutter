import 'package:feature_global_search_impl/src/screen/global_search/tile/model/model.dart';
import 'package:flutter/material.dart';
import 'package:tile/tile.dart';

class MusicResultTileFactoryDelegate
    implements ITileFactoryDelegate<MusicResultTileModel> {
  const MusicResultTileFactoryDelegate();

  @override
  Widget create(BuildContext context, MusicResultTileModel model) {
    // todo: implement widget
    return ListTile(
      title: Text('${model.runtimeType}'),
    );
  }
}
