import 'package:flutter/widgets.dart';

import '../split_view.dart';

class SplitViewScope extends InheritedWidget {
  const SplitViewScope({
    super.key,
    required super.child,
    required SplitViewState state,
    required int version,
  })  : _state = state,
        _version = version;

  final SplitViewState _state;
  final int _version;

  static SplitViewState of(BuildContext context) {
    final SplitViewScope? result =
        context.dependOnInheritedWidgetOfExactType<SplitViewScope>();
    assert(result != null, 'No SplitViewScope found in context');
    return result!._state;
  }

  // todo: handle update
  @override
  bool updateShouldNotify(SplitViewScope oldWidget) =>
      oldWidget._version != _version;
}
