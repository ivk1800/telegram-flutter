import 'package:core_arch_flutter/core_arch_flutter.dart';
import 'package:coreui/coreui.dart' as tg;
import 'package:feature_wallpapers_impl/src/screen/wallpaper_list/wallpaper_list_bloc.dart';
import 'package:feature_wallpapers_impl/src/screen/wallpaper_list/wallpaper_list_state.dart';
import 'package:feature_wallpapers_impl/src/tile/model/model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:localization_api/localization_api.dart';
import 'package:tile/tile.dart';

class WallpaperListPage extends StatelessWidget {
  const WallpaperListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final ILocalizationManager localizationManager = context.read();
    final tg.TgAppBarFactory appBarFactory = context.read();
    final WallpaperListViewModel viewModel = context.read();

    return Scaffold(
      appBar: appBarFactory.createDefaultTitle(
        context,
        localizationManager.getString('ChatBackground'),
      ),
      body: StreamListener<WallpaperListState>(
        stream: viewModel.state,
        builder: (BuildContext context, WallpaperListState state) {
          return AnimatedSwitcher(
            child: _Body(state: state),
            duration: const Duration(milliseconds: 200),
          );
        },
      ),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body({
    required this.state,
  });

  final WallpaperListState state;

  @override
  Widget build(BuildContext context) {
    return state.when(
      (List<ITileModel> backgrounds) => LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) => _Grid(
          tileModels: backgrounds,
          width: constraints.maxWidth,
        ),
      ),
      loading: () => const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}

class _Grid extends StatelessWidget {
  const _Grid({
    required this.tileModels,
    required this.width,
  });

  final List<ITileModel> tileModels;
  final double width;

  @override
  Widget build(BuildContext context) {
    final TileFactory tileFactory = context.read();

    return StaggeredGridView.countBuilder(
      crossAxisCount: kCrossAxisCount,
      itemCount: tileModels.length,
      crossAxisSpacing: 8,
      mainAxisSpacing: 8,
      // todo fix padding for bottom and top tiles
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      itemBuilder: (BuildContext context, int index) {
        return tileFactory.create(context, tileModels[index]);
      },
      staggeredTileBuilder: (int index) {
        final ITileModel tileModel = tileModels[index];

        if (tileModel is TopGroupTileModel ||
            tileModel is BottomGroupTileModel) {
          return const StaggeredTile.fit(kCrossAxisCount);
        }

        return StaggeredTile.extent(2, width / (kCrossAxisCount / 2) * 1.5);
      },
    );
  }

  static const int kCrossAxisCount = 6;
}
