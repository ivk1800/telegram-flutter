import 'package:coreui/coreui.dart' as tg;
import 'package:feature_change_username_impl/src/di/change_username_screen_component.dart';
import 'package:feature_change_username_impl/src/screen/change_username/change_username_view_model.dart';
import 'package:flutter/widgets.dart';
import 'package:localization_api/localization_api.dart';
import 'package:provider_extensions/provider_extensions.dart';

import 'change_username_screen_widget_model.dart';

class ChangeUsernameScreenScope extends StatefulWidget {
  const ChangeUsernameScreenScope({
    super.key,
    required this.child,
    required this.create,
  });

  final Widget child;
  final CreateComponent<IChangeUsernameScreenComponent> create;

  @override
  State<ChangeUsernameScreenScope> createState() =>
      _ChangeUsernameScreenScopeState();

  static IStringsProvider getStringsProvider(BuildContext context) =>
      _InheritedScope.of(context)._stringsProvider;

  static tg.TgAppBarFactory getTgAppBarFactory(BuildContext context) =>
      _InheritedScope.of(context)._tgAppBarFactory;

  static ChangeUsernameScreenWidgetModel getChangeUsernameScreenWidgetModel(
    BuildContext context,
  ) =>
      _InheritedScope.of(context)._changeUsernameScreenWidgetModel;
}

class _ChangeUsernameScreenScopeState extends State<ChangeUsernameScreenScope> {
  late final IChangeUsernameScreenComponent _component = widget.create.call();

  late final IStringsProvider _stringsProvider =
      _component.getStringsProvider();

  late final tg.TgAppBarFactory _tgAppBarFactory =
      _component.getTgAppBarFactory();

  late final ChangeUsernameScreenWidgetModel _changeUsernameScreenWidgetModel =
      _component.getChangeUsernameScreenWidgetModel();

  late final ChangeUsernameViewModel _changeUsernameViewModel =
      _component.getChangeUsernameViewModel();

  @override
  Widget build(BuildContext context) {
    return _InheritedScope(
      holderState: this,
      child: widget.child,
    );
  }

  @override
  void dispose() {
    _changeUsernameViewModel.dispose();
    _changeUsernameScreenWidgetModel.dispose();
    super.dispose();
  }
}

class _InheritedScope extends InheritedWidget {
  const _InheritedScope({
    required super.child,
    required _ChangeUsernameScreenScopeState holderState,
  }) : _state = holderState;

  final _ChangeUsernameScreenScopeState _state;

  static _ChangeUsernameScreenScopeState of(BuildContext context) {
    final _ChangeUsernameScreenScopeState? result = (context
            .getElementForInheritedWidgetOfExactType<_InheritedScope>()
            ?.widget as _InheritedScope?)
        ?._state;
    assert(result != null, 'No ChangeUsernameScreenScope found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(_InheritedScope oldWidget) => false;
}
