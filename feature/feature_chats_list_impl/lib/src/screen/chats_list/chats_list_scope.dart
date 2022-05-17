import 'package:feature_chats_list_impl/src/di/chats_list_screen_component.dart';
import 'package:flutter/widgets.dart';
import 'package:provider_extensions/provider_extensions.dart';
import 'package:tile/tile.dart';

import 'chats_list_view_model.dart';

class ChatsListScope extends StatefulWidget {
  const ChatsListScope({
    super.key,
    required this.child,
    required this.create,
  });

  final Widget child;
  final CreateComponent<IChatsListScreenComponent> create;

  @override
  State<ChatsListScope> createState() => _ChatsListScopeState();

  static ChatsListViewModel getChatsListViewModel(BuildContext context) =>
      _InheritedScope.of(context)._chatsListViewModel;

  static TileFactory getTileFactory(BuildContext context) =>
      _InheritedScope.of(context)._tileFactory;
}

class _ChatsListScopeState extends State<ChatsListScope> {
  late final IChatsListScreenComponent _component = widget.create.call();

  late final TileFactory _tileFactory = _component.getTileFactory();

  late final ChatsListViewModel _chatsListViewModel =
      _component.getChatsListViewModel();

  @override
  Widget build(BuildContext context) {
    return _InheritedScope(
      holderState: this,
      child: widget.child,
    );
  }

  @override
  void dispose() {
    _chatsListViewModel.dispose();
    super.dispose();
  }
}

class _InheritedScope extends InheritedWidget {
  const _InheritedScope({
    required super.child,
    required _ChatsListScopeState holderState,
  }) : _state = holderState;

  final _ChatsListScopeState _state;

  static _ChatsListScopeState of(BuildContext context) {
    final _ChatsListScopeState? result = (context
            .getElementForInheritedWidgetOfExactType<_InheritedScope>()
            ?.widget as _InheritedScope?)
        ?._state;
    assert(result != null, 'No ChatsListScope found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(_InheritedScope oldWidget) => false;
}
