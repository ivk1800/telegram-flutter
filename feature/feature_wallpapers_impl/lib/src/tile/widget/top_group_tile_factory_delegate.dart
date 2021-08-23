import 'package:coreui/coreui.dart' as tg;
import 'package:feature_wallpapers_impl/src/tile/model/model.dart';
import 'package:flutter/material.dart';
import 'package:localization_api/localization_api.dart';
import 'package:tile/tile.dart';

class TopGroupTileFactoryDelegate
    implements ITileFactoryDelegate<TopGroupTileModel> {
  const TopGroupTileFactoryDelegate({
    required ILocalizationManager localizationManager,
  }) : _localizationManager = localizationManager;

  final ILocalizationManager _localizationManager;

  @override
  Widget create(BuildContext context, TopGroupTileModel model) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        tg.TextCell(
          onTap: () {},
          title: _localizationManager.getString('SelectFromGallery'),
          leading: const Icon(Icons.circle),
        ),
        tg.TextCell(
          onTap: () {},
          title: _localizationManager.getString('SetColor'),
          leading: const Icon(Icons.circle),
        ),
        const tg.SectionDivider(),
      ],
    );
  }
}
