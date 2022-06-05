import 'package:chat_actions_panel/chat_actions_panel.dart';
import 'package:feature_chat_header_info_api/feature_chat_header_info_api.dart';
import 'package:feature_chat_impl/src/di/chat_screen_component.dart';
import 'package:feature_chat_impl/src/screen/chat/chat_screen.dart';
import 'package:feature_chat_impl/src/screen/chat/message_factory.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:localization_api/localization_api.dart';

import 'chat_widget_model.dart';
import 'message_factory.dart';

class ChatScreenScope extends StatefulWidget {
  const ChatScreenScope({
    super.key,
    required this.child,
    required this.create,
  });

  final Widget child;
  final IChatScreenComponent Function() create;

  @override
  State<ChatScreenScope> createState() => _ChatScreenScopeState();

  static ChatActionPanelFactory getChatActionPanelFactory(
    BuildContext context,
  ) =>
      _InheritedScope.of(context)._chatActionPanelFactory;

  static MessageFactory getMessageFactory(BuildContext context) =>
      _InheritedScope.of(context)._messageFactory;

  static IStringsProvider getStringsProvider(BuildContext context) =>
      _InheritedScope.of(context)._stringsProvider;

  static IChatHeaderInfoFactory getChatHeaderInfoFactory(
    BuildContext context,
  ) =>
      _InheritedScope.of(context)._chatHeaderInfoFactory;

  static ChatMessagesViewModel getChatMessagesViewModel(BuildContext context) =>
      _InheritedScope.of(context)._chatMessagesViewModel;

  static ChatActionBarViewModel getChatActionBarModel(BuildContext context) =>
      _InheritedScope.of(context)._chatActionBarModel;

  static ChatWidgetModel getChatWidgetModel(BuildContext context) =>
      _InheritedScope.of(context)._chatWidgetModel;
}

class _ChatScreenScopeState extends State<ChatScreenScope> {
  late final IChatScreenComponent _component = widget.create.call();

  late final ChatWidgetModel _chatWidgetModel = _component.getChatWidgetModel();

  late final ChatActionPanelFactory _chatActionPanelFactory =
      _component.getChatActionPanelFactory();

  late final MessageFactory _messageFactory = _component.getMessageFactory();

  late final IStringsProvider _stringsProvider =
      _component.getStringsProvider();

  late final IChatHeaderInfoFactory _chatHeaderInfoFactory =
      _component.getChatHeaderInfoFactory();

  late final ChatMessagesViewModel _chatMessagesViewModel =
      _component.getChatMessagesViewModel();

  late final ChatActionBarViewModel _chatActionBarModel =
      _component.getChatActionBarViewModel();

  @override
  Widget build(BuildContext context) {
    return _InheritedScope(
      holderState: this,
      child: widget.child,
    );
  }

  @override
  void dispose() {
    _chatMessagesViewModel.dispose();
    _chatActionBarModel.dispose();
    _chatWidgetModel.dispose();
    super.dispose();
  }
}

class _InheritedScope extends InheritedWidget {
  const _InheritedScope({
    required super.child,
    required _ChatScreenScopeState holderState,
  }) : _state = holderState;

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
