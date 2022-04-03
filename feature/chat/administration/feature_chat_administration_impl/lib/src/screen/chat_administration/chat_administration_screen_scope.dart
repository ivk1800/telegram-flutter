import 'package:feature_chat_administration_impl/src/di/chat_administration_screen_component.dart';
import 'package:flutter/widgets.dart';
import 'package:localization_api/localization_api.dart';
import 'package:provider_extensions/provider_extensions.dart';

import 'chat_administration_view_model.dart';

class ChatAdministrationScreenScope extends StatefulWidget {
  const ChatAdministrationScreenScope({
    Key? key,
    required this.child,
    required this.create,
  }) : super(key: key);

  final Widget child;
  final CreateComponent<IChatAdministrationScreenComponent> create;

  @override
  State<ChatAdministrationScreenScope> createState() =>
      _ChatAdministrationScreenScopeState();

  static IStringsProvider getStringsProvider(BuildContext context) =>
      _InheritedScope.of(context)._stringsProvider;

  static ChatAdministrationViewModel getChatAdministrationViewModel(
          BuildContext context) =>
      _InheritedScope.of(context)._newContactViewModel;
}

class _ChatAdministrationScreenScopeState
    extends State<ChatAdministrationScreenScope> {
  late final IChatAdministrationScreenComponent _component =
      widget.create.call();

  late final IStringsProvider _stringsProvider =
      _component.getStringsProvider();
  late final ChatAdministrationViewModel _newContactViewModel =
      _component.getChatAdministrationViewModel();

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
    required _ChatAdministrationScreenScopeState holderState,
  })  : _state = holderState,
        super(key: key, child: child);

  final _ChatAdministrationScreenScopeState _state;

  static _ChatAdministrationScreenScopeState of(BuildContext context) {
    final _ChatAdministrationScreenScopeState? result = (context
            .getElementForInheritedWidgetOfExactType<_InheritedScope>()
            ?.widget as _InheritedScope?)
        ?._state;
    assert(result != null, 'No ChatAdministrationScreenScope found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(_InheritedScope oldWidget) => false;
}
