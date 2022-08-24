import 'package:feature_create_new_chat_impl/src/di/create_new_chat_screen/create_new_chat_screen_component.dart';
import 'package:flutter/widgets.dart';
import 'package:localization_api/localization_api.dart';

import 'new_chat_view_model.dart';

class NewChatScreenScope extends StatefulWidget {
  const NewChatScreenScope({
    super.key,
    required this.child,
    required this.create,
  });

  final Widget child;
  final ICreateNewChatScreenComponent Function() create;

  @override
  State<NewChatScreenScope> createState() => _NewChatScreenScopeState();

  static NewChatViewModel getNewChatViewModel(BuildContext context) =>
      _InheritedScope.of(context)._viewModel;

  static IStringsProvider getStringsProvider(BuildContext context) =>
      _InheritedScope.of(context)._stringsProvider;
}

class _NewChatScreenScopeState extends State<NewChatScreenScope> {
  late final ICreateNewChatScreenComponent _component = widget.create.call();

  late final NewChatViewModel _viewModel = _component.getNewChatViewModel();
  late final IStringsProvider _stringsProvider =
      _component.getStringsProvider();

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
    required _NewChatScreenScopeState holderState,
  }) : _state = holderState;

  final _NewChatScreenScopeState _state;

  static _NewChatScreenScopeState of(BuildContext context) {
    final _NewChatScreenScopeState? result = (context
            .getElementForInheritedWidgetOfExactType<_InheritedScope>()
            ?.widget as _InheritedScope?)
        ?._state;
    assert(result != null, 'No NewChatScreenScope found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(_InheritedScope oldWidget) => false;
}
