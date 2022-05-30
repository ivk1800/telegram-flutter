import 'package:flutter/widgets.dart';
import 'avatar_view_model.dart';

class AvatarScope extends StatefulWidget {
  const AvatarScope({
    super.key,
    required this.child,
    required this.create,
  });

  final Widget child;
  final AvatarViewModel Function() create;

  @override
  State<AvatarScope> createState() => _AvatarScopeState();

  static AvatarViewModel getViewModel(BuildContext context) =>
      _InheritedScope.of(context)._viewModel;
}

class _AvatarScopeState extends State<AvatarScope> {
  late final AvatarViewModel _viewModel = widget.create.call();

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
    required _AvatarScopeState holderState,
  }) : _state = holderState;

  final _AvatarScopeState _state;

  static _AvatarScopeState of(BuildContext context) {
    final _AvatarScopeState? result = (context
            .getElementForInheritedWidgetOfExactType<_InheritedScope>()
            ?.widget as _InheritedScope?)
        ?._state;
    assert(result != null, 'No AvatarScope found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(_InheritedScope oldWidget) => false;
}
