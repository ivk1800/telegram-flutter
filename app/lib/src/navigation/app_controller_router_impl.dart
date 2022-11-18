import 'package:app/src/widget/right_container_placeholder_factory.dart';
import 'package:app_controller/app_controller.dart';
import 'package:feature_auth_api/feature_auth_api.dart';
import 'package:feature_main_screen_api/feature_main_screen_api.dart';
import 'package:flutter/material.dart';
import 'package:split_view/split_view.dart';

class AppControllerRouterImpl implements IAppControllerRouter {
  AppControllerRouterImpl({
    required GlobalKey<SplitViewState> navigationKey,
    required IMainScreenFactory mainScreenFactory,
    required IAuthScreenFactory authScreenFactory,
    required RightContainerPlaceholderFactory placeholderFactory,
  })  : _navigationKey = navigationKey,
        _authScreenFactory = authScreenFactory,
        _placeholderFactory = placeholderFactory,
        _mainScreenFactory = mainScreenFactory;

  final GlobalKey<SplitViewState> _navigationKey;
  final IMainScreenFactory _mainScreenFactory;
  final IAuthScreenFactory _authScreenFactory;
  final RightContainerPlaceholderFactory _placeholderFactory;

  @override
  void toRoot() {
    final SplitViewState? currentState = _navigationKey.currentState;
    if (currentState == null) {
      return;
    }

    final Widget mainScreenWidget = _mainScreenFactory.create();
    currentState
      ..removeUntil(ContainerType.left, (_) => false)
      ..removeUntil(ContainerType.right, (_) => false)
      ..removeUntil(ContainerType.top, (_) => false)
      ..setRightContainerPlaceholder(
        Builder(builder: _placeholderFactory.create),
      )
      ..add(
        key: UniqueKey(),
        builder: (_) => mainScreenWidget,
        container: ContainerType.left,
      );
  }

  @override
  void toLogin() {
    _push(
      _authScreenFactory.create(),
      ContainerType.top,
    );
  }

  void _push(Widget widget, ContainerType container) {
    _navigationKey.currentState?.add(
      key: UniqueKey(),
      builder: (_) => widget,
      container: container,
    );
  }
}
