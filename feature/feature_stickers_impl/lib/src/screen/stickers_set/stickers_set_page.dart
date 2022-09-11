import 'package:core_arch_flutter/core_arch_flutter.dart';
import 'package:feature_stickers_impl/src/screen/stickers_set/stickers_set_screen_scope_delegate.scope.dart';
import 'package:flutter/material.dart';
import 'package:tile/tile.dart';

import 'stickers_set_state.dart';

class StickerSetPage extends StatelessWidget {
  const StickerSetPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const _AppBar(),
      body: StreamListener<StickersSetState>(
        stream: StickersSetScreenScope.getStickersSetViewModel(context).state,
        builder: (BuildContext context, StickersSetState state) {
          return state.map(
            loading: (_) {
              return const Center(child: CircularProgressIndicator());
            },
            data: (StickersSetStateData value) {
              return _Grid(tileModels: value.models);
            },
          );
        },
      ),
    );
  }
}

class _AppBar extends StatelessWidget implements PreferredSizeWidget {
  const _AppBar();

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: StreamListener<StickersSetState>(
        stream: StickersSetScreenScope.getStickersSetViewModel(context).state,
        builder: (BuildContext context, StickersSetState state) {
          return state.map(
            loading: (_) {
              return const SizedBox.shrink();
            },
            data: (StickersSetStateData value) {
              return Text(value.setName);
            },
          );
        },
      ),
    );
  }

  @override
  Size get preferredSize => const Size(double.infinity, kToolbarHeight);
}

class _Grid extends StatelessWidget {
  const _Grid({
    required this.tileModels,
  });

  final List<ITileModel> tileModels;

  @override
  Widget build(BuildContext context) {
    final TileFactory tileFactory =
        StickersSetScreenScope.getTileFactory(context);

    return GridView.builder(
      itemCount: tileModels.length,
      itemBuilder: (BuildContext context, int index) {
        final ITileModel tileModel = tileModels[index];
        return tileFactory.create(context, tileModel);
      },
      padding: const EdgeInsets.all(8.0),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 5,
        crossAxisSpacing: 8.0,
        mainAxisSpacing: 8.0,
      ),
    );
  }
}
