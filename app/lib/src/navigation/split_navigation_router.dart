import 'package:flutter/material.dart';
import 'package:split_view/split_view.dart';

import 'navigation_router.dart';

class SplitNavigationDelegateImpl implements ISplitNavigationDelegate {
  SplitNavigationDelegateImpl(
    GlobalKey<SplitViewState> navigationKey,
  ) : _navigationKey = navigationKey;

  final GlobalKey<SplitViewState> _navigationKey;

  @override
  void pushAllReplacement({
    required LocalKey key,
    required WidgetBuilder builder,
    required ContainerType container,
  }) {
    _navigationKey.currentState
        ?.pushAllReplacement(key: key, builder: builder, container: container);
  }

  @override
  void push({
    required LocalKey key,
    required WidgetBuilder builder,
    required ContainerType container,
  }) {
    _navigationKey.currentState?.push(
      key: key,
      builder: builder,
      container: container,
    );
  }

  @override
  void back() {
    _navigationKey.currentState?.pop();
  }
}
