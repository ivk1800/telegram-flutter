import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:presentation/src/feature/feature.dart';
import 'package:presentation/src/feature/folders/feature_folders.dart';
import 'package:presentation/src/page/page.dart';
import 'package:split_view/split_view.dart';

import 'navigation_router.dart';

class SplitNavigationRouter implements INavigationRouter {
  SplitNavigationRouter(
      GlobalKey<SplitViewState> navigationKey, FeatureFactory featureFactory)
      : _navigationKey = navigationKey,
        _featureFactory = featureFactory;

  final GlobalKey<SplitViewState> _navigationKey;
  final FeatureFactory _featureFactory;

  @override
  void back() {
    // _navigationKey.currentState?.pop();
  }

  @override
  void toSessionsScreen() {
    _push(const SessionsPage(), ContainerType.Top);
  }

  @override
  void toLogin() {
    _push(const LoginPage(), ContainerType.Top);
  }

  @override
  void toFolders() {
    _push(const FoldersSetupPage().wrap(), ContainerType.Top);
  }

  @override
  void toRoot() {
    final SplitViewState? currentState = _navigationKey.currentState;
    if (currentState == null) {
      return;
    }

    currentState.popUntilRoot(ContainerType.Left);
    currentState.popUntilRoot(ContainerType.Top);
    currentState.popUntilRoot(ContainerType.Right);
    currentState.setRightContainerPlaceholder(const Material(
      child: Center(
        // TODO extract to strings
        child: Text('Select a chat to start messaging'),
      ),
    ));
    currentState.setLeftRootPage(
        _featureFactory.createMainScreenFeature().screenWidgetFactory.create());
  }

  void pushAllReplacement(
      {required LocalKey key,
      required WidgetBuilder builder,
      required ContainerType container}) {
    _navigationKey.currentState
        ?.pushAllReplacement(key: key, builder: builder, container: container);
  }

  void push(
      {required LocalKey key,
      required WidgetBuilder builder,
      required ContainerType container}) {
    _navigationKey.currentState
        ?.push(key: key, builder: builder, container: container);
  }

  bool hasKey(LocalKey key, ContainerType container) =>
      _navigationKey.currentState?.hasKey(key, container) ?? false;

  void _push(Widget widget, ContainerType container) {
    _navigationKey.currentState
        ?.push(key: UniqueKey(), builder: (_) => widget, container: container);
  }
}
