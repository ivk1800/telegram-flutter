import 'package:feature_chat_impl/src/tile/model/loading_tile_model.dart';
import 'package:flutter/material.dart';
import 'package:tile/tile.dart';

class LoadingTileFactoryDelegate
    implements ITileFactoryDelegate<LoadingTileModel> {
  const LoadingTileFactoryDelegate();

  @override
  Widget create(BuildContext context, LoadingTileModel model) {
    return const Center(child: CircularProgressIndicator());
  }
}
