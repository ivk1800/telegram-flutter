import 'package:feature_global_search_impl/src/screen/global_search/tile/model/model.dart';
import 'package:flutter/material.dart';
import 'package:tile/tile.dart';

class LinkResultTileFactoryDelegate
    implements ITileFactoryDelegate<LinkResultTileModel> {
  const LinkResultTileFactoryDelegate();

  @override
  Widget create(BuildContext context, LinkResultTileModel model) {
    // todo: implement widget
    return ListTile(
      title: Text('${model.runtimeType}'),
    );
  }
}
