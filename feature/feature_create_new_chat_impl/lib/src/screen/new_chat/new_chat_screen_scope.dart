import 'package:feature_create_new_chat_impl/src/di/di.dart';
import 'package:flutter/widgets.dart';
import 'package:localization_api/localization_api.dart';
import 'package:provider_extensions/provider_extensions.dart';

import 'new_chat_view_model.dart';

class NewChatScreenScope extends StatefulWidget {
  const NewChatScreenScope({
    Key? key,
    required this.child,
    required this.create,
  }) : super(key: key);

  final Widget child;
  final CreateComponent<CreateNewChatScreenComponent> create;

  @override
  State<NewChatScreenScope> createState() => _NewChatScreenScopeState();

  static NewChatViewModel getNewChatViewModel(BuildContext context) =>
      _InheritedScope.of(context)._viewModel;

  static ILocalizationManager getILocalizationManager(BuildContext context) =>
      _InheritedScope.of(context)._localizationManager;
}

class _NewChatScreenScopeState extends State<NewChatScreenScope> {
  late final CreateNewChatScreenComponent _component = widget.create.call();

  late final NewChatViewModel _viewModel = _component.getNewChatViewModel();
  late final ILocalizationManager _localizationManager =
      _component.getLocalizationManager();

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
    required _NewChatScreenScopeState holderState,
  })  : _state = holderState,
        super(key: key, child: child);

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
