import 'package:coreui/coreui.dart' as tg;
import 'package:feature_wallpapers_impl/src/screen/wallpaper_list/bloc/wallpaper_list_bloc.dart';
import 'package:feature_wallpapers_impl/src/screen/wallpaper_list/bloc/wallpaper_list_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:localization_api/localization_api.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class WallpaperListPage extends StatelessWidget {
  const WallpaperListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ILocalizationManager localizationManager = context.read();
    final tg.TgAppBarFactory appBarFactory = context.read();

    return Scaffold(
      appBar: appBarFactory.createDefaultTitle(
        context,
        localizationManager.getString('ChatBackground'),
      ),
      body: BlocConsumer<WallpaperListBloc, WallpaperListState>(
        listener: (BuildContext context, WallpaperListState state) {},
        builder: (BuildContext context, WallpaperListState state) {
          return AnimatedSwitcher(
            child: _stateToWidget(state),
            duration: const Duration(milliseconds: 200),
          );
        },
      ),
    );
  }

  Widget _stateToWidget(WallpaperListState state) {
    switch (state.runtimeType) {
      case LoadingState:
        {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      case WallpapersState:
        {
          return LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) =>
                _buildGridView(
              context: context,
              tileModels: (state as WallpapersState).backgrounds,
              width: constraints.maxWidth,
            ),
          );
        }
    }
    throw StateError('unexpected state ${state.runtimeType}');
  }

  Widget _buildGridView({
    required BuildContext context,
    required List<tg.ITileModel> tileModels,
    required double width,
  }) {
    final tg.TileFactory tileFactory = context.read();

    return StaggeredGridView.countBuilder(
        crossAxisCount: CrossAxisCount,
        shrinkWrap: false,
        itemCount: tileModels.length,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
        padding: const EdgeInsets.all(10.0),
        itemBuilder: (BuildContext context, int index) {
          return tileFactory.create(context, tileModels[index]);
        },
        staggeredTileBuilder: (int index) {
          return StaggeredTile.extent(2, width / (CrossAxisCount / 2) * 1.5);
        });
  }

  static const int CrossAxisCount = 6;
}
