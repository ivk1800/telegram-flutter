import 'package:coreui/coreui.dart';
import 'package:feature_new_contact_impl/src/di/new_contact_screen_component.dart';
import 'package:feature_new_contact_impl/src/screen/new_contact/new_contact_widget_model.dart';
import 'package:flutter/widgets.dart';
import 'package:localization_api/localization_api.dart';

import 'new_contact_view_model.dart';

class NewContactScreenScope extends StatefulWidget {
  const NewContactScreenScope({
    super.key,
    required this.child,
    required this.create,
  });

  final Widget child;
  final INewContactScreenComponent Function() create;

  @override
  State<NewContactScreenScope> createState() => _NewContactScreenScopeState();

  static IStringsProvider getStringsProvider(BuildContext context) =>
      _InheritedScope.of(context)._stringsProvider;

  static NewContactViewModel getNewContactsViewModel(BuildContext context) =>
      _InheritedScope.of(context)._newContactViewModel;

  static NewContactWidgetModel getNewContactWidgetModel(BuildContext context) =>
      _InheritedScope.of(context)._newContactWidgetModel;

  static AvatarWidgetFactory getAvatarWidgetFactory(BuildContext context) =>
      _InheritedScope.of(context)._avatarWidgetFactory;
}

class _NewContactScreenScopeState extends State<NewContactScreenScope> {
  late final INewContactScreenComponent _component = widget.create.call();

  late final IStringsProvider _stringsProvider =
      _component.getStringsProvider();
  late final NewContactViewModel _newContactViewModel =
      _component.getNewContactViewModel();
  late final NewContactWidgetModel _newContactWidgetModel =
      _component.getNewContactWidgetModel();
  late final AvatarWidgetFactory _avatarWidgetFactory =
      _component.getAvatarWidgetFactory();

  @override
  Widget build(BuildContext context) {
    return _InheritedScope(
      holderState: this,
      child: widget.child,
    );
  }

  @override
  void dispose() {
    _newContactViewModel.dispose();
    _newContactWidgetModel.dispose();
    super.dispose();
  }
}

class _InheritedScope extends InheritedWidget {
  const _InheritedScope({
    required super.child,
    required _NewContactScreenScopeState holderState,
  }) : _state = holderState;

  final _NewContactScreenScopeState _state;

  static _NewContactScreenScopeState of(BuildContext context) {
    final _NewContactScreenScopeState? result = (context
            .getElementForInheritedWidgetOfExactType<_InheritedScope>()
            ?.widget as _InheritedScope?)
        ?._state;
    assert(result != null, 'No NewContactScreenScope found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(_InheritedScope oldWidget) => false;
}
