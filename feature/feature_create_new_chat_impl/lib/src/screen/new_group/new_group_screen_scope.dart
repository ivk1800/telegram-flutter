import 'package:feature_create_new_chat_impl/src/di/create_new_group_screen_component.dart';
import 'package:flutter/widgets.dart';

import 'new_group_view_model.dart';

class CreateNewGroupScreenScope extends StatefulWidget {
  const CreateNewGroupScreenScope({
    super.key,
    required this.child,
    required this.create,
  });

  final Widget child;
  final ICreateNewGroupScreenComponent Function() create;

  @override
  State<CreateNewGroupScreenScope> createState() =>
      _CreateNewGroupScreenScopeState();

  static NewGroupViewModel getNewGroupViewModel(BuildContext context) =>
      _InheritedScope.of(context)._viewModel;
}

class _CreateNewGroupScreenScopeState extends State<CreateNewGroupScreenScope> {
  late final ICreateNewGroupScreenComponent _component = widget.create.call();

  late final NewGroupViewModel _viewModel = _component.getNewGroupViewModel();

  @override
  Widget build(BuildContext context) {
    return _InheritedScope(
      holderState: this,
      child: widget.child,
    );
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
    required _CreateNewGroupScreenScopeState holderState,
  }) : _state = holderState;

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
