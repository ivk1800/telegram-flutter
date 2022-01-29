import 'package:flutter/widgets.dart';

import '../split_view.dart';

class SplitViewScope extends InheritedWidget {
  const SplitViewScope({
    Key? key,
    required Widget child,
    required SplitViewState state,
  })  : _state = state,
        super(key: key, child: child);

  final SplitViewState _state;

  static SplitViewState of(BuildContext context) {
    final SplitViewScope? result =
        context.dependOnInheritedWidgetOfExactType<SplitViewScope>();
    assert(result != null, 'No SplitViewScope found in context');
    return result!._state;
  }

  // todo: handle update
  @override
  bool updateShouldNotify(SplitViewScope oldWidget) => true;
}
