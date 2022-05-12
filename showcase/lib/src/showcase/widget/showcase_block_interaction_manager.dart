import 'package:block_interaction_api/block_interaction_api.dart';
import 'package:flutter/foundation.dart';
import 'package:jugger/jugger.dart' as j;

@j.singleton
class ShowcaseBlockInteractionManager extends ValueNotifier<bool>
    implements IBlockInteractionManager {
  @j.inject
  ShowcaseBlockInteractionManager() : super(false);

  @override
  void setState({required bool active}) {
    value = active;
  }
}
