import 'package:app_controller/app_controller_component.dart';
import 'package:feature_auth_api/feature_auth_api.dart';
import 'package:feature_main_screen_api/feature_main_screen_api.dart';
import 'package:flutter/material.dart';
import 'package:split_view/split_view.dart';

class AppControllerRouterImpl implements IAppControllerRouter {
  AppControllerRouterImpl({
    required GlobalKey<SplitViewState> navigationKey,
    required IMainScreenFactory mainScreenFactory,
    required IAuthScreenFactory authScreenFactory,
  })  : _navigationKey = navigationKey,
        _authScreenFactory = authScreenFactory,
        _mainScreenFactory = mainScreenFactory;

  final GlobalKey<SplitViewState> _navigationKey;
  final IMainScreenFactory _mainScreenFactory;
  final IAuthScreenFactory _authScreenFactory;

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
      ..setLeftRootPage(_mainScreenFactory.create());
  }

  @override
  void toLogin() {
    _push(
      _authScreenFactory.create(),
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
