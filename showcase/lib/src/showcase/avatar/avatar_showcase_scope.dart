import 'package:coreui/coreui.dart';
import 'package:flutter/widgets.dart';
import 'package:showcase/src/showcase/avatar/avatar_showcase_repository.dart';

import 'avatar_showcase_component.dart';

class AvatarShowcaseScope extends StatefulWidget {
  const AvatarShowcaseScope({
    super.key,
    required this.child,
    required this.create,
  });

  final Widget child;
  final AvatarShowcaseComponent Function() create;

  @override
  State<AvatarShowcaseScope> createState() => _AvatarShowcaseScopeState();

  static AvatarWidgetFactory getAvatarWidgetFactory(BuildContext context) =>
      _InheritedScope.of(context)._component.avatarWidgetFactory;

  static AvatarsRepository getAvatarsRepository(BuildContext context) =>
      _InheritedScope.of(context)._component.avatarsRepository;
}

class _AvatarShowcaseScopeState extends State<AvatarShowcaseScope> {
  late final AvatarShowcaseComponent _component = widget.create.call();

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
    required _AvatarShowcaseScopeState holderState,
  }) : _state = holderState;

  final _AvatarShowcaseScopeState _state;

  static _AvatarShowcaseScopeState of(BuildContext context) {
    final _AvatarShowcaseScopeState? result = (context
            .getElementForInheritedWidgetOfExactType<_InheritedScope>()
            ?.widget as _InheritedScope?)
        ?._state;
    assert(result != null, 'No AvatarShowcaseScope found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(_InheritedScope oldWidget) => false;
}
