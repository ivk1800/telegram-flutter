import 'package:chat_actions_panel/chat_actions_panel.dart';
import 'package:feature_chat_header_info_api/feature_chat_header_info_api.dart';
import 'package:feature_chat_impl/src/di/di.dart';
import 'package:feature_chat_impl/src/screen/chat/chat_screen.dart';
import 'package:feature_chat_impl/src/screen/chat/message_factory.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:localization_api/localization_api.dart';
import 'package:provider_extensions/provider_extensions.dart';

import 'message_factory.dart';

class ChatScreenScope extends StatefulWidget {
  const ChatScreenScope({
    Key? key,
    required this.child,
    required this.create,
  }) : super(key: key);

  final Widget child;
  final CreateComponent<IChatScreenComponent> create;

  @override
  State<ChatScreenScope> createState() => _ChatScreenScopeState();

  static IChatActionPanelFactory getChatActionPanelFactory(
          BuildContext context) =>
      _InheritedScope.of(context)._chatActionPanelFactory;

  static MessageFactory getMessageFactory(BuildContext context) =>
      _InheritedScope.of(context)._messageFactory;

  static IStringsProvider getStringsProvider(BuildContext context) =>
      _InheritedScope.of(context)._stringsProvider;

  static IChatHeaderInfoFactory getChatHeaderInfoFactory(
          BuildContext context) =>
      _InheritedScope.of(context)._chatHeaderInfoFactory;

  static ChatViewModel getChatViewModel(BuildContext context) =>
      _InheritedScope.of(context)._chatViewModel;

  static ChatActionBarViewModel getChatActionBarModel(BuildContext context) =>
      _InheritedScope.of(context)._chatActionBarModel;

  static ChatActionsPanelViewModel getChatActionsPanelViewModel(
          BuildContext context) =>
      _InheritedScope.of(context)._chatActionsPanelViewModel;
}

class _ChatScreenScopeState extends State<ChatScreenScope> {
  late final IChatScreenComponent _component = widget.create.call();

  late final IChatActionPanelFactory _chatActionPanelFactory =
      _component.getChatActionPanelFactory();

  late final MessageFactory _messageFactory = _component.getMessageFactory();

  late final IStringsProvider _stringsProvider =
      _component.getLocalizationManager().stringsProvider;

  late final IChatHeaderInfoFactory _chatHeaderInfoFactory =
      _component.getChatHeaderInfoFactory();

  late final ChatViewModel _chatViewModel = _component.getChatViewModel();

  late final ChatActionBarViewModel _chatActionBarModel =
      _component.getChatActionBarViewModel();

  late final ChatActionsPanelViewModel _chatActionsPanelViewModel =
      _component.getChatActionsPanelViewModel();

  @override
  Widget build(BuildContext context) {
    return _InheritedScope(
      holderState: this,
      child: widget.child,
    );
  }

  @override
  void dispose() {
    _chatViewModel.dispose();
    _chatActionBarModel.dispose();
    _chatActionsPanelViewModel.dispose();
    super.dispose();
  }
}

class _InheritedScope extends InheritedWidget {
  const _InheritedScope({
    Key? key,
    required Widget child,
    required _ChatScreenScopeState holderState,
  })  : _state = holderState,
        super(key: key, child: child);

  final _ChatScreenScopeState _state;

  static _ChatScreenScopeState of(BuildContext context) {
    final _ChatScreenScopeState? result = (context
            .getElementForInheritedWidgetOfExactType<_InheritedScope>()
            ?.widget as _InheritedScope?)
        ?._state;
    assert(result != null, 'No ChatScreenScope found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(_InheritedScope oldWidget) => false;
}
