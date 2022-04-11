import 'package:block_interaction_api/block_interaction_api.dart';
import 'package:flutter/foundation.dart';

class ShowcaseBlockInteractionManager extends ValueNotifier<bool>
    implements IBlockInteractionManager {
  ShowcaseBlockInteractionManager() : super(false);

  @override
  void setState({required bool active}) {
    value = active;
  }
}
