import 'package:app/src/feature/feature.dart';
import 'package:app/src/feature/folders/feature_folders.dart';
import 'package:app/src/page/page.dart';
import 'package:feature_auth_api/feature_auth_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:split_view/split_view.dart';

import 'navigation_router.dart';

class SplitNavigationRouter implements INavigationRouter {
  SplitNavigationRouter(
    GlobalKey<SplitViewState> navigationKey,
    FeatureFactory featureFactory,
  )   : _navigationKey = navigationKey,
        _featureFactory = featureFactory;

  final GlobalKey<SplitViewState> _navigationKey;
  final FeatureFactory _featureFactory;

  @override
  void back() {
    _navigationKey.currentState?.pop();
  }

  @override
  void toSessionsScreen() {
    _push(const SessionsPage(), ContainerType.top);
  }

  @override
  void toLogin() {
    final IAuthScreenFactory factory =
        _featureFactory.createAuthFeatureApi().authScreenFactory;
    _push(
      Builder(
        builder: factory.create,
      ),
      ContainerType.top,
    );
  }

  @override
  void toFolders() {
    _push(const FoldersSetupPage().wrap(), ContainerType.top);
  }

  @override
  void toRoot() {
    final SplitViewState? currentState = _navigationKey.currentState;
    if (currentState == null) {
      return;
    }

    currentState
      ..popUntilRoot(ContainerType.left)
      ..popUntilRoot(ContainerType.top)
      ..popUntilRoot(ContainerType.right)
      ..setRightContainerPlaceholder(const Material(
        child: Center(
          // TODO extract to strings
          child: Text('Select a chat to start messaging'),
        ),
      ))
      ..setLeftRootPage(
        _featureFactory.createMainScreenFeature().mainScreenFactory.create(),
      );
  }

  void pushAllReplacement({
    required LocalKey key,
    required WidgetBuilder builder,
    required ContainerType container,
  }) {
    _navigationKey.currentState
        ?.pushAllReplacement(key: key, builder: builder, container: container);
  }

  void push({
    required LocalKey key,
    required WidgetBuilder builder,
    required ContainerType container,
  }) {
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
