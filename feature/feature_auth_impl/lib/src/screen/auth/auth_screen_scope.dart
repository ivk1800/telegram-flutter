import 'package:feature_auth_impl/src/di/di.dart';
import 'package:flutter/widgets.dart';
import 'package:localization_api/localization_api.dart';
import 'package:provider_extensions/provider_extensions.dart';

import 'view_model/auth_view_model.dart';

class AuthScreenScope extends StatefulWidget {
  const AuthScreenScope({
    super.key,
    required this.child,
    required this.create,
  });

  final Widget child;
  final CreateComponent<IAuthScreenComponent> create;

  @override
  State<AuthScreenScope> createState() => _AuthScreenScopeState();

  static AuthViewModel getAuthViewModel(BuildContext context) =>
      _InheritedScope.of(context)._viewModel;

  static IStringsProvider getStringsProvider(BuildContext context) =>
      _InheritedScope.of(context)._stringsProvider;
}

class _AuthScreenScopeState extends State<AuthScreenScope> {
  late final IAuthScreenComponent _component = widget.create.call();

  late final AuthViewModel _viewModel = _component.getAuthViewModel();
  late final IStringsProvider _stringsProvider =
      _component.getStringsProvider();

  @override
  Widget build(BuildContext context) {
    return _InheritedScope(state: this, child: widget.child);
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }
}

class _InheritedScope extends InheritedWidget {
  const _InheritedScope({
    required super.child,
    required _AuthScreenScopeState state,
  }) : _state = state;

  final _AuthScreenScopeState _state;

  static _AuthScreenScopeState of(BuildContext context) {
    final _AuthScreenScopeState? result = (context
            .getElementForInheritedWidgetOfExactType<_InheritedScope>()
            ?.widget as _InheritedScope?)
        ?._state;
    assert(result != null, 'No AuthScreenScope found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(_InheritedScope oldWidget) => false;
}
