import 'package:feature_chat_forum_impl/src/screen/tile/model/topic_tile_model.dart';
import 'package:feature_chat_forum_impl/src/screen/tile/widget/topic_tile_factory_delegate.dart';
import 'package:jugger/jugger.dart' as j;
import 'package:tile/tile.dart';

@j.module
abstract class ChatForumScreenModule {
  @j.provides
  @j.singleton
  static TileFactory provideTileFactory() => TileFactory(
        delegates: <Type, ITileFactoryDelegate<ITileModel>>{
          TopicTileModel: TopicTileFactoryDelegate(),
        },
      );
}
