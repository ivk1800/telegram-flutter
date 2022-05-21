import 'package:flutter/widgets.dart';
import 'package:tile/tile.dart';

import 'message_showcase_component.dart';
import 'message_showcase_view_model.dart';

class MessageShowcaseScope extends StatefulWidget {
  const MessageShowcaseScope({
    super.key,
    required this.child,
    required this.create,
  });

  final Widget child;
  final IMessageShowcaseComponent Function() create;

  @override
  State<MessageShowcaseScope> createState() => _MessageShowcaseScopeState();

  static MessageShowcaseViewModel getMessageShowcaseViewModel(
    BuildContext context,
  ) =>
      _InheritedScope.of(context)._messageShowcaseViewModel;

  static TileFactory getTileFactory(BuildContext context) =>
      _InheritedScope.of(context)._tileFactory;
}

class _MessageShowcaseScopeState extends State<MessageShowcaseScope> {
  late final IMessageShowcaseComponent _component = widget.create.call();

  late final MessageShowcaseViewModel _messageShowcaseViewModel =
      _component.getMessageShowcaseViewModel();

  late final TileFactory _tileFactory = _component.getTileFactory();

  @override
  Widget build(BuildContext context) {
    return _InheritedScope(
      holderState: this,
      child: widget.child,
    );
  }

  @override
  void dispose() {
    _messageShowcaseViewModel.dispose();
    super.dispose();
  }
}

class _InheritedScope extends InheritedWidget {
  const _InheritedScope({
    required super.child,
    required _MessageShowcaseScopeState holderState,
  }) : _state = holderState;

  final _MessageShowcaseScopeState _state;

  static _MessageShowcaseScopeState of(BuildContext context) {
    final _MessageShowcaseScopeState? result = (context
            .getElementForInheritedWidgetOfExactType<_InheritedScope>()
            ?.widget as _InheritedScope?)
        ?._state;
    assert(result != null, 'No MessageShowcaseScope found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(_InheritedScope oldWidget) => false;
}
