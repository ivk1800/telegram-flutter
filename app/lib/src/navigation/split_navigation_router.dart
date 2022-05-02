import 'package:flutter/material.dart';
import 'package:split_view/split_view.dart';

import 'navigation_router.dart';

class SplitNavigationDelegateImpl implements ISplitNavigationDelegate {
  SplitNavigationDelegateImpl(
    GlobalKey<SplitViewState> navigationKey,
  ) : _navigationKey = navigationKey;

  final GlobalKey<SplitViewState> _navigationKey;

  @override
  void removeUntil(ContainerType container, bool Function(LocalKey key) test) {
    _navigationKey.currentState?.removeUntil(
      container,
      (PageNode node) => test.call(node.pageKey),
    );
  }

  @override
  void add({
    required LocalKey key,
    required WidgetBuilder builder,
    required ContainerType container,
  }) {
    _navigationKey.currentState?.add(
      key: key,
      builder: builder,
      container: container,
    );
  }

  @override
  void removeByKey(LocalKey key) {
    _navigationKey.currentState?.removeByKey(key);
  }
}
