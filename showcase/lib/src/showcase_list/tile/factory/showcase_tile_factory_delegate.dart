import 'package:flutter/material.dart';
import 'package:showcase/src/showcase_list/showcase_params.dart';
import 'package:showcase/src/showcase_list/tile/model/showcase_tile_model.dart';
import 'package:tile/tile.dart';

class ShowcaseTileFactoryDelegate
    implements ITileFactoryDelegate<ShowcaseTileModel> {
  const ShowcaseTileFactoryDelegate({required this.onTap});

  final void Function(ShowcaseParams params) onTap;

  @override
  Widget create(BuildContext context, ShowcaseTileModel model) {
    final String? description = model.description;
    return ListTile(
      title: Text(model.title),
      subtitle: description != null ? Text(description) : null,
      onTap: () => onTap.call(model.params),
    );
  }
}
