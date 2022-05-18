import 'package:flutter/widgets.dart';
import 'package:localization_api/localization_api.dart';
import 'package:provider_extensions/provider_extensions.dart';

import 'chat_actions_panel_component.dart';
import 'chat_actions_panel_view_model.dart';

class ChatActionPanelScope extends StatefulWidget {
  const ChatActionPanelScope({
    super.key,
    required this.child,
    required this.create,
  });

  final Widget child;
  final CreateComponent<IChatActionsPanelComponent> create;

  @override
  State<ChatActionPanelScope> createState() => _ChatActionPanelScopeState();

  static ChatActionsPanelViewModel getChatActionsPanelViewModel(
    BuildContext context,
  ) =>
      _InheritedScope.of(context)._chatActionsPanelViewModel;

  static IStringsProvider getStringsProvider(BuildContext context) =>
      _InheritedScope.of(context)._stringsProvider;
}

class _ChatActionPanelScopeState extends State<ChatActionPanelScope> {
  late final IChatActionsPanelComponent _component = widget.create.call();

  late final ChatActionsPanelViewModel _chatActionsPanelViewModel =
      _component.chatActionsPanelViewModel;

  late final IStringsProvider _stringsProvider = _component.stringsProvider;

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
    required _ChatActionPanelScopeState holderState,
  }) : _state = holderState;

  final _ChatActionPanelScopeState _state;

  static _ChatActionPanelScopeState of(BuildContext context) {
    final _ChatActionPanelScopeState? result = (context
            .getElementForInheritedWidgetOfExactType<_InheritedScope>()
            ?.widget as _InheritedScope?)
        ?._state;
    assert(result != null, 'No ChatActionPanelScope found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(_InheritedScope oldWidget) => false;
}
