import 'package:block_interaction_api/block_interaction_api.dart';
import 'package:flutter/foundation.dart';
import 'package:jugger/jugger.dart' as j;

@j.singleton
class BlockInteractionManager extends ValueNotifier<bool>
    implements IBlockInteractionManager {
  @j.inject
  BlockInteractionManager() : super(false);

  @override
  void setState({required bool active}) {
    value = active;
  }
}
