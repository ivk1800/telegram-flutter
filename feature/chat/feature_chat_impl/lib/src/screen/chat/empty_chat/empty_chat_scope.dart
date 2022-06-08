import 'package:feature_chat_impl/src/screen/chat/empty_chat/empty_chat_view_model.dart';
import 'package:flutter/widgets.dart';
import 'package:localization_api/localization_api.dart';

import 'empty_chat_component.dart';

class EmptyChatScope extends StatefulWidget {
  const EmptyChatScope({
    super.key,
    required this.child,
    required this.create,
  });

  final Widget child;
  final IEmptyChatComponent Function() create;

  @override
  State<EmptyChatScope> createState() => _EmptyChatScopeState();

  static EmptyChatViewModel getEmptyChatViewModel(BuildContext context) =>
      _InheritedScope.of(context)._emptyChatViewModel;

  static IStringsProvider getStringsProvider(BuildContext context) =>
      _InheritedScope.of(context)._stringsProvider;
}

class _EmptyChatScopeState extends State<EmptyChatScope> {
  late final IEmptyChatComponent _component = widget.create.call();

  late final EmptyChatViewModel _emptyChatViewModel = _component.viewModel;

  late final IStringsProvider _stringsProvider = _component.stringsProvider;

  @override
  Widget build(BuildContext context) {
    return _InheritedScope(
      holderState: this,
      child: widget.child,
    );
  }

  @override
  void dispose() {
    _emptyChatViewModel.dispose();
    super.dispose();
  }
}

class _InheritedScope extends InheritedWidget {
  const _InheritedScope({
    required super.child,
    required _EmptyChatScopeState holderState,
  }) : _state = holderState;

  final _EmptyChatScopeState _state;

  static _EmptyChatScopeState of(BuildContext context) {
    final _EmptyChatScopeState? result = (context
            .getElementForInheritedWidgetOfExactType<_InheritedScope>()
            ?.widget as _InheritedScope?)
        ?._state;
    assert(result != null, 'No EmptyChatScope found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(_InheritedScope oldWidget) => false;
}
