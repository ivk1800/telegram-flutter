import 'package:coreui/coreui.dart' as tg;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:localization_api/localization_api.dart';
import 'package:provider/provider.dart';
import 'package:tile/tile.dart';

import 'bloc/stickers_bloc.dart';
import 'bloc/stickers_event.dart';
import 'bloc/stickers_state.dart';

class StickersPage extends StatelessWidget {
  const StickersPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ILocalizationManager localizationManager = Provider.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Provider.of<tg.ConnectionStateWidgetFactory>(context).create(
          context,
          (BuildContext context) => Text(
            localizationManager.getString('StickersAndMasks'),
          ),
        ),
      ),
      body: BlocBuilder<StickersBloc, StickersState>(
        builder: (BuildContext context, StickersState state) {
          if (state is DefaultState) {
            return SingleChildScrollView(
              child: _buildDefaultWidget(
                context,
                state,
              ),
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }

  Widget _buildDefaultWidget(BuildContext context, DefaultState state) {
    final ILocalizationManager localizationManager = Provider.of(context);
    final TileFactory tileFactory = Provider.of<TileFactory>(context);
    final StickersBloc bloc = BlocProvider.of(context);
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
          onTap: () => bloc.add(const TrendingStickersTap()),
          title: localizationManager.getString('FeaturedStickers'),
        ),
        const tg.Divider(),
        tg.TextCell.textValue(
          value: '1',
          onTap: () => bloc.add(const ArchivedStickersTap()),
          title: localizationManager.getString('ArchivedStickers'),
        ),
        const tg.Divider(),
        tg.TextCell.textValue(
          value: '7',
          onTap: () => bloc.add(const MasksTap()),
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
