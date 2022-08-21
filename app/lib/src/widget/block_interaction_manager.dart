import 'package:app/src/di/scope/application_scope.dart';
import 'package:block_interaction_api/block_interaction_api.dart';
import 'package:flutter/foundation.dart';
import 'package:jugger/jugger.dart' as j;

@applicationScope
class BlockInteractionManager extends ValueNotifier<bool>
    implements IBlockInteractionManager {
  @j.inject
  BlockInteractionManager() : super(false);

  @override
  void setState({required bool active}) {
    value = active;
  }
}
