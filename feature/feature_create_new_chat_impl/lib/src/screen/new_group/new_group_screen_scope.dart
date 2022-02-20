import 'package:feature_create_new_chat_impl/src/di/di.dart';
import 'package:flutter/widgets.dart';
import 'package:provider_extensions/provider_extensions.dart';

import 'new_group_view_model.dart';

class CreateNewGroupScreenScope extends StatefulWidget {
  const CreateNewGroupScreenScope({
    Key? key,
    required this.child,
    required this.create,
  }) : super(key: key);

  final Widget child;
  final CreateComponent<CreateNewGroupScreenComponent> create;

  @override
  State<CreateNewGroupScreenScope> createState() =>
      _CreateNewGroupScreenScopeState();

  static NewGroupViewModel getNewGroupViewModel(BuildContext context) =>
      _InheritedScope.of(context)._viewModel;
}

class _CreateNewGroupScreenScopeState extends State<CreateNewGroupScreenScope> {
  late final CreateNewGroupScreenComponent _component = widget.create.call();

  late final NewGroupViewModel _viewModel = _component.getNewGroupViewModel();

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
    required _CreateNewGroupScreenScopeState holderState,
  })  : _state = holderState,
        super(key: key, child: child);

  final _CreateNewGroupScreenScopeState _state;

  static _CreateNewGroupScreenScopeState of(BuildContext context) {
    final _CreateNewGroupScreenScopeState? result = (context
            .getElementForInheritedWidgetOfExactType<_InheritedScope>()
            ?.widget as _InheritedScope?)
        ?._state;
    assert(result != null, 'No CreateNewGroupScreenScope found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(_InheritedScope oldWidget) => false;
}
