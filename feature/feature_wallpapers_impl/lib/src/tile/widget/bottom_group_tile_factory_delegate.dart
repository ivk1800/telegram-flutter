import 'package:coreui/coreui.dart' as tg;
import 'package:feature_wallpapers_impl/src/tile/model/model.dart';
import 'package:flutter/material.dart';
import 'package:localization_api/localization_api.dart';
import 'package:tile/tile.dart';

class BottomGroupTileFactoryDelegate
    implements ITileFactoryDelegate<BottomGroupTileModel> {
  const BottomGroupTileFactoryDelegate({
    required ILocalizationManager localizationManager,
  }) : _localizationManager = localizationManager;

  final ILocalizationManager _localizationManager;

  @override
  Widget create(BuildContext context, BottomGroupTileModel model) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        tg.TextCell(
          onTap: () {},
          title: _localizationManager.getString('ResetChatBackgrounds'),
        ),
        tg.Annotation(
          text: _localizationManager.getString('ResetChatBackgroundsInfo'),
        ),
      ],
    );
  }
}
