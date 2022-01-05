import 'package:app/src/feature/feature.dart';
import 'package:app_controller/app_controller_component.dart';
import 'package:feature_auth_api/feature_auth_api.dart';
import 'package:flutter/material.dart';
import 'package:split_view/split_view.dart';

class AppControllerRouterImpl implements IAppControllerRouter {
  AppControllerRouterImpl(
    GlobalKey<SplitViewState> navigationKey,
    FeatureFactory featureFactory,
  )   : _navigationKey = navigationKey,
        _featureFactory = featureFactory;

  final GlobalKey<SplitViewState> _navigationKey;
  final FeatureFactory _featureFactory;

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
      ..setRightContainerPlaceholder(
        const Material(
          child: Center(
            // TODO extract to strings
            child: Text('Select a chat to start messaging'),
          ),
        ),
      )
      ..setLeftRootPage(
        _featureFactory.createMainScreenFeature().mainScreenFactory.create(),
      );
  }

  @override
  void toLogin() {
    final IAuthScreenFactory factory =
        _featureFactory.createAuthFeatureApi().authScreenFactory;
    _push(
      factory.create(),
      ContainerType.top,
    );
  }

  void _push(Widget widget, ContainerType container) {
    _navigationKey.currentState?.push(
      key: UniqueKey(),
      builder: (_) => widget,
      container: container,
    );
  }
}
