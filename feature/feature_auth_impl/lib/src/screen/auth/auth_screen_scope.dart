import 'package:core_arch_flutter/core_arch_flutter.dart';
import 'package:coreui/coreui.dart' as tg;
import 'package:feature_auth_impl/src/di/auth_screen_component.dart';
import 'package:flutter/widgets.dart';
import 'package:localization_api/localization_api.dart';

import 'auth_screen_vidget_model.dart';

class AuthScreenScope extends BaseScope<_AuthScreenScopeDelegate> {
  AuthScreenScope({
    super.key,
    required super.child,
    required IAuthScreenComponent Function() create,
  }) : super(
          create: () => _AuthScreenScopeDelegate(component: create.call()),
        );

  static IStringsProvider getStringsProvider(BuildContext context) =>
      BaseScope.getScopeDelegate<_AuthScreenScopeDelegate>(context)
          ._stringsProvider;

  static AuthScreenWidgetModel getAuthScreenWidgetModel(BuildContext context) =>
      BaseScope.getScopeDelegate<_AuthScreenScopeDelegate>(context)
          ._authScreenWidgetModel;

  static tg.TgAppBarFactory getTgAppBarFactory(BuildContext context) =>
      BaseScope.getScopeDelegate<_AuthScreenScopeDelegate>(context)
          ._tgAppBarFactory;
}

class _AuthScreenScopeDelegate extends ScopeDelegate {
  _AuthScreenScopeDelegate({
    required IAuthScreenComponent component,
  }) : _component = component;

  final IAuthScreenComponent _component;

  late final AuthScreenWidgetModel _authScreenWidgetModel =
      _component.getAuthScreenWidgetModel();

  late final IStringsProvider _stringsProvider =
      _component.getStringsProvider();

  late final tg.TgAppBarFactory _tgAppBarFactory =
      _component.getTgAppBarFactory();

  @override
  void onDispose() {
    _component.scopeDisposer.dispose();
    super.onDispose();
  }
}
