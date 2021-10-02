import 'package:feature_global_search_impl/src/screen/global_search/tile/model/model.dart';
import 'package:flutter/material.dart';
import 'package:tile/tile.dart';

class VoiceResultTileFactoryDelegate
    implements ITileFactoryDelegate<VoiceResultTileModel> {
  const VoiceResultTileFactoryDelegate();

  @override
  Widget create(BuildContext context, VoiceResultTileModel model) {
    // todo: implement widget
    return ListTile(
      title: Text('${model.runtimeType}'),
    );
  }
}
