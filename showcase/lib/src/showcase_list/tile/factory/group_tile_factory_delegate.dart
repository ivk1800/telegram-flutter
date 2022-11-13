import 'package:flutter/material.dart';
import 'package:showcase/src/showcase_list/tile/model/group_tile_model.dart';
import 'package:tile/tile.dart';

class GroupTileFactoryDelegate implements ITileFactoryDelegate<GroupTileModel> {
  const GroupTileFactoryDelegate({required this.onTap});

  final void Function(GroupTileModel model) onTap;

  @override
  Widget create(BuildContext context, GroupTileModel model) {
    return ListTile(
      title: Text(model.title),
      onTap: () => onTap.call(model),
      trailing: const Icon(Icons.arrow_forward_ios_rounded),
    );
  }
}
