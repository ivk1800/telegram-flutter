import 'package:feature_change_bio_impl/src/di/change_bio_screen_component.dart';
import 'package:flutter/widgets.dart';
import 'package:localization_api/localization_api.dart';
import 'package:provider_extensions/provider_extensions.dart';

class ChangeBioScreenScope extends StatefulWidget {
  const ChangeBioScreenScope({
    Key? key,
    required this.child,
    required this.create,
  }) : super(key: key);

  final Widget child;
  final CreateComponent<IChangeBioScreenComponent> create;

  @override
  State<ChangeBioScreenScope> createState() => _ChangeBioScreenScopeState();

  static IStringsProvider getStringsProvider(BuildContext context) =>
      _InheritedScope.of(context)._stringsProvider;
}

class _ChangeBioScreenScopeState extends State<ChangeBioScreenScope> {
  late final IChangeBioScreenComponent _component = widget.create.call();

  late final IStringsProvider _stringsProvider =
      _component.getStringsProvider();

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
    required _ChangeBioScreenScopeState holderState,
  })  : _state = holderState,
        super(key: key, child: child);

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
