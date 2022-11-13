import 'package:jugger/jugger.dart' as j;
import 'package:showcase/src/di/scope/screen_scope.dart';
import 'package:showcase/src/showcase_list/showcase_list_view_model.dart';
import 'package:showcase/src/showcase_list/tile/factory/group_tile_factory_delegate.dart';
import 'package:showcase/src/showcase_list/tile/factory/showcase_tile_factory_delegate.dart';
import 'package:showcase/src/showcase_list/tile/model/group_tile_model.dart';
import 'package:showcase/src/showcase_list/tile/model/showcase_tile_model.dart';
import 'package:tile/tile.dart';

@j.module
abstract class ShowcaseListScreenModule {
  @j.provides
  @screenScope
  static TileFactory provideTileFactory(
    ShowcaseListViewModel viewModel,
  ) =>
      TileFactory(
        delegates: <Type, ITileFactoryDelegate<ITileModel>>{
          GroupTileModel: GroupTileFactoryDelegate(
            onTap: viewModel.onGroupTap,
          ),
          ShowcaseTileModel: ShowcaseTileFactoryDelegate(
            onTap: viewModel.onShowcaseTap,
          ),
        },
      );
}
