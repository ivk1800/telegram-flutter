import 'package:feature_change_bio_impl/src/di/change_bio_screen_component.dart';
import 'package:flutter/widgets.dart';
import 'package:localization_api/localization_api.dart';

import 'change_bio_view_model.dart';

class ChangeBioScreenScope extends StatefulWidget {
  const ChangeBioScreenScope({
    super.key,
    required this.child,
    required this.create,
  });

  final Widget child;
  final IChangeBioScreenComponent Function() create;

  @override
  State<ChangeBioScreenScope> createState() => _ChangeBioScreenScopeState();

  static IStringsProvider getStringsProvider(BuildContext context) =>
      _InheritedScope.of(context)._stringsProvider;
}

class _ChangeBioScreenScopeState extends State<ChangeBioScreenScope> {
  late final IChangeBioScreenComponent _component = widget.create.call();

  late final IStringsProvider _stringsProvider =
      _component.getStringsProvider();

  late final ChangeBioViewModel _changeBioViewModel =
      _component.getChangeBioViewModel();

  @override
  Widget build(BuildContext context) {
    return _InheritedScope(
      holderState: this,
      child: widget.child,
    );
  }

  @override
  void dispose() {
    _changeBioViewModel.dispose();
    super.dispose();
  }
}

class _InheritedScope extends InheritedWidget {
  const _InheritedScope({
    required super.child,
    required _ChangeBioScreenScopeState holderState,
  }) : _state = holderState;

  final _ChangeBioScreenScopeState _state;

  static _ChangeBioScreenScopeState of(BuildContext context) {
    final _ChangeBioScreenScopeState? result = (context
            .getElementForInheritedWidgetOfExactType<_InheritedScope>()
            ?.widget as _InheritedScope?)
        ?._state;
    assert(result != null, 'No ChangeBioScreenScope found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(_InheritedScope oldWidget) => false;
}
