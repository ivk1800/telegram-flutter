import 'package:feature_shared_media_impl/src/di/shared_media_component.dart';
import 'package:flutter/widgets.dart';
import 'package:provider_extensions/provider_extensions.dart';

import 'share_media_view_model.dart';

class SharedMediaScreenScope extends StatefulWidget {
  const SharedMediaScreenScope({
    super.key,
    required this.child,
    required this.create,
  });

  final Widget child;
  final CreateComponent<ISharedMediaComponent> create;

  @override
  State<SharedMediaScreenScope> createState() => _SharedMediaScreenScopeState();

  static SharedMediaViewModel getSharedMediaViewModel(BuildContext context) =>
      _InheritedScope.of(context)._sharedMediaViewModel;
}

class _SharedMediaScreenScopeState extends State<SharedMediaScreenScope> {
  late final ISharedMediaComponent _component = widget.create.call();

  late final SharedMediaViewModel _sharedMediaViewModel =
      _component.getSharedMediaViewModel();

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
    required super.child,
    required _SharedMediaScreenScopeState holderState,
  }) : _state = holderState;

  final _SharedMediaScreenScopeState _state;

  static _SharedMediaScreenScopeState of(BuildContext context) {
    final _SharedMediaScreenScopeState? result = (context
            .getElementForInheritedWidgetOfExactType<_InheritedScope>()
            ?.widget as _InheritedScope?)
        ?._state;
    assert(result != null, 'No SharedMediaScreenScope found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(_InheritedScope oldWidget) => false;
}
