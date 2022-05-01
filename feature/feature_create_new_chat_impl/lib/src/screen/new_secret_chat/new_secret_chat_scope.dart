import 'package:feature_create_new_chat_impl/src/di/di.dart';
import 'package:flutter/widgets.dart';
import 'package:provider_extensions/provider_extensions.dart';

import 'new_secret_chat.dart';

class NewSecretChatScreenScope extends StatefulWidget {
  const NewSecretChatScreenScope({
    Key? key,
    required this.child,
    required this.create,
  }) : super(key: key);

  final Widget child;
  final CreateComponent<CreateNewSecretChatScreenComponent> create;

  @override
  State<NewSecretChatScreenScope> createState() =>
      _NewSecretChatScreenScopeState();

  static NewSecretChatViewModel getNewSecretChatViewModel(
    BuildContext context,
  ) =>
      _InheritedScope.of(context)._viewModel;
}

class _NewSecretChatScreenScopeState extends State<NewSecretChatScreenScope> {
  late final CreateNewSecretChatScreenComponent _component =
      widget.create.call();

  late final NewSecretChatViewModel _viewModel =
      _component.getNewSecretChatViewModel();

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
    Key? key,
    required Widget child,
    required _NewSecretChatScreenScopeState holderState,
  })  : _state = holderState,
        super(key: key, child: child);

  final _NewSecretChatScreenScopeState _state;

  static _NewSecretChatScreenScopeState of(BuildContext context) {
    final _NewSecretChatScreenScopeState? result = (context
            .getElementForInheritedWidgetOfExactType<_InheritedScope>()
            ?.widget as _InheritedScope?)
        ?._state;
    assert(result != null, 'No NewSecretChatScreenScope found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(_InheritedScope oldWidget) => false;
}
