import 'package:feature_new_contact_impl/src/di/new_contact_screen_component.dart';
import 'package:flutter/widgets.dart';
import 'package:localization_api/localization_api.dart';
import 'package:provider_extensions/provider_extensions.dart';

import 'new_contact_view_model.dart';

class NewContactScreenScope extends StatefulWidget {
  const NewContactScreenScope({
    Key? key,
    required this.child,
    required this.create,
  }) : super(key: key);

  final Widget child;
  final CreateComponent<INewContactScreenComponent> create;

  @override
  State<NewContactScreenScope> createState() => _NewContactScreenScopeState();

  static IStringsProvider getStringsProvider(BuildContext context) =>
      _InheritedScope.of(context)._stringsProvider;

  static NewContactViewModel getNewContactsViewModel(BuildContext context) =>
      _InheritedScope.of(context)._newContactViewModel;
}

class _NewContactScreenScopeState extends State<NewContactScreenScope> {
  late final INewContactScreenComponent _component = widget.create.call();

  late final IStringsProvider _stringsProvider =
      _component.getStringsProvider();
  late final NewContactViewModel _newContactViewModel =
      _component.getNewContactViewModel();

  @override
  Widget build(BuildContext context) {
    return _InheritedScope(
      holderState: this,
      child: widget.child,
    );
  }
}

class _InheritedScope extends InheritedWidget {
  const _InheritedScope({
    Key? key,
    required Widget child,
    required _NewContactScreenScopeState holderState,
  })  : _state = holderState,
        super(key: key, child: child);

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
