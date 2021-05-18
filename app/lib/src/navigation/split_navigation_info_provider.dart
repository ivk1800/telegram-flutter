import 'package:flutter/widgets.dart';
import 'package:split_view/split_view.dart';

class SplitNavigationInfoProvider {
  SplitNavigationInfoProvider(GlobalKey<SplitViewState> navigationKey)
      : _navigationKey = navigationKey;

  final GlobalKey<SplitViewState> _navigationKey;

  bool hasKey(LocalKey key, ContainerType container) =>
      _navigationKey.currentState?.hasKey(key, container) ?? false;
}
