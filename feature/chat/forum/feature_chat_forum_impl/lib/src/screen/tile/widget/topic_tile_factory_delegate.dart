import 'package:feature_chat_forum_impl/src/screen/tile/model/topic_tile_model.dart';
import 'package:flutter/material.dart';
import 'package:tile/tile.dart';

class TopicTileFactoryDelegate implements ITileFactoryDelegate<TopicTileModel> {
  @override
  Widget create(BuildContext context, TopicTileModel model) {
    return Container(height: 48, color: Colors.grey.shade100);
  }
}
