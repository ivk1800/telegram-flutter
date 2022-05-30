import 'package:coreui/coreui.dart';
import 'package:feature_global_search_impl/src/screen/global_search/tile/model/model.dart';
import 'package:flutter/material.dart';
import 'package:tile/tile.dart';

class MediaResultTileFactoryDelegate
    implements ITileFactoryDelegate<MediaResultTileModel> {
  const MediaResultTileFactoryDelegate({
    required AvatarWidgetFactory avatarWidgetFactory,
  }) : _avatarWidgetFactory = avatarWidgetFactory;

  final AvatarWidgetFactory _avatarWidgetFactory;

  @override
  Widget create(BuildContext context, MediaResultTileModel model) {
    return ListTile(
      onTap: () {},
      leading: _avatarWidgetFactory.create(
        context,
        avatar: model.avatar,
        radius: 25,
      ),
      title: Text.rich(
        model.title,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      subtitle: Text.rich(
        model.subtitle,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
