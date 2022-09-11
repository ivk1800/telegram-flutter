import 'package:core_arch_flutter/core_arch_flutter.dart';
import 'package:coreui/coreui.dart' as tg;
import 'package:flutter/material.dart';
import 'package:localization_api/localization_api.dart';
import 'package:provider/provider.dart';
import 'package:tile/tile.dart';

import 'stickers_event.dart';
import 'stickers_state.dart';
import 'stickers_view_model.dart';

class StickersPage extends StatelessWidget {
  const StickersPage({super.key});

  @override
  Widget build(BuildContext context) {
    final IStringsProvider stringsProvider = Provider.of(context);
    final StickersViewModel viewModel = Provider.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Provider.of<tg.ConnectionStateWidgetFactory>(context).create(
          context,
          (BuildContext context) => Text(stringsProvider.stickersAndMasks),
        ),
      ),
      body: StreamListener<StickersState>(
        stream: viewModel.state,
        builder: (BuildContext context, StickersState state) {
          return state.map(
            data: (Data state) {
              return SingleChildScrollView(
                child: _DefaultWidget(
                  state: state,
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class _DefaultWidget extends StatelessWidget {
  const _DefaultWidget({required this.state});

  final Data state;

  @override
  Widget build(BuildContext context) {
    final ILocalizationManager localizationManager = Provider.of(context);
    final TileFactory tileFactory = Provider.of<TileFactory>(context);
    final StickersViewModel viewModel = Provider.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        tg.TextCell.textValue(
          onTap: () {},
          value: 'All sets',
          title: localizationManager.getString('SuggestStickers'),
        ),
        const tg.Divider(),
        tg.TextCell.toggle(
          onTap: () {},
          title: localizationManager.getString('LoopAnimatedStickers'),
          value: true,
          onChanged: (bool value) {},
        ),
        const tg.Divider(
          indent: tg.DividerIndent.none,
        ),
        tg.Annotation(
          text: localizationManager.getString('LoopAnimatedStickersInfo'),
        ),
        tg.TextCell.textValue(
          value: '18',
          onTap: () => viewModel.onEvent(const TrendingStickersTap()),
          title: localizationManager.getString('FeaturedStickers'),
        ),
        const tg.Divider(),
        tg.TextCell.textValue(
          value: '1',
          onTap: () => viewModel.onEvent(const ArchivedStickersTap()),
          title: localizationManager.getString('ArchivedStickers'),
        ),
        const tg.Divider(),
        tg.TextCell.textValue(
          value: '7',
          onTap: () => viewModel.onEvent(const MasksTap()),
          title: localizationManager.getString('Masks'),
        ),
        tg.Annotation(
          text: localizationManager.getString('StickersBotInfo'),
        ),
        ListView.separated(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: state.tiles.length,
          itemBuilder: (BuildContext context, int index) =>
              tileFactory.create(context, state.tiles[index]),
          separatorBuilder: (BuildContext context, int index) => const Divider(
            height: 1,
          ),
        ),
      ],
    );
  }
}
