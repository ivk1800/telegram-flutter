import 'package:feature_chat_impl/feature_chat_impl.dart';
import 'package:feature_chat_impl/src/widget/chat_message/chat_message_factory.dart';
import 'package:flutter/widgets.dart';

import 'message_sticker_bloc.dart';
import 'message_sticker_dependencies.dart';

class MessageStickerScope extends StatefulWidget {
  const MessageStickerScope({
    super.key,
    required this.child,
    required this.create,
    required this.model,
  });

  final Widget child;
  final MessageStickerTileModel model;
  final MessageStickerDependencies Function() create;

  @override
  State<MessageStickerScope> createState() => _MessageStickerScopeState();

  static MessageStickerBloc getBloc(BuildContext context) =>
      _InheritedScope.of(context)._bloc;

  static ChatMessageFactory getChatMessageFactory(BuildContext context) =>
      _InheritedScope.of(context)._chatMessageFactory;
}

class _MessageStickerScopeState extends State<MessageStickerScope> {
  late final MessageStickerDependencies _dependencies = widget.create.call();
  late final MessageStickerBloc _bloc = _dependencies.blocProvider.get();
  late final ChatMessageFactory _chatMessageFactory =
      _dependencies.chatMessageFactory;

  @override
  void initState() {
    _bloc.dispatchModel(widget.model);
    super.initState();
  }

  @override
  void didUpdateWidget(covariant MessageStickerScope oldWidget) {
    if (widget.model != oldWidget.model) {
      _bloc.dispatchModel(widget.model);
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return _InheritedScope(
      holderState: this,
      child: widget.child,
    );
  }

  @override
  void dispose() {
    _bloc.onDispose();
    super.dispose();
  }
}

class _InheritedScope extends InheritedWidget {
  const _InheritedScope({
    required super.child,
    required _MessageStickerScopeState holderState,
  }) : _state = holderState;

  final _MessageStickerScopeState _state;

  static _MessageStickerScopeState of(BuildContext context) {
    final _MessageStickerScopeState? result = (context
            .getElementForInheritedWidgetOfExactType<_InheritedScope>()
            ?.widget as _InheritedScope?)
        ?._state;
    assert(result != null, 'No MessageStickerScope found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(_InheritedScope oldWidget) => false;
}
