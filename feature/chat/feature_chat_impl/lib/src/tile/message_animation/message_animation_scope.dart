import 'package:feature_chat_impl/feature_chat_impl.dart';
import 'package:feature_chat_impl/src/widget/chat_message/chat_message_factory.dart';
import 'package:flutter/widgets.dart';

import '../../widget/chat_message/reply_info_factory.dart';
import '../../widget/chat_message/short_info_factory.dart';
import 'message_animation_bloc.dart';
import 'message_animation_dependencies.dart';

class MessageAnimationScope extends StatefulWidget {
  const MessageAnimationScope({
    super.key,
    required this.child,
    required this.create,
    required this.model,
  });

  final Widget child;
  final MessageAnimationTileModel model;
  final MessageAnimationDependencies Function() create;

  @override
  State<MessageAnimationScope> createState() => _MessageAnimationScopeState();

  static MessageAnimationBloc getBloc(BuildContext context) =>
      _InheritedScope.of(context)._bloc;

  static ChatMessageFactory getChatMessageFactory(BuildContext context) =>
      _InheritedScope.of(context)._chatMessageFactory;

  static ShortInfoFactory getShortInfoFactory(BuildContext context) =>
      _InheritedScope.of(context)._shortInfoFactory;

  static ReplyInfoFactory getReplyInfoFactory(BuildContext context) =>
      _InheritedScope.of(context)._replyInfoFactory;
}

class _MessageAnimationScopeState extends State<MessageAnimationScope> {
  late final MessageAnimationDependencies _dependencies = widget.create.call();
  late final MessageAnimationBloc _bloc = _dependencies.bloc;
  late final ChatMessageFactory _chatMessageFactory =
      _dependencies.chatMessageFactory;
  late final ReplyInfoFactory _replyInfoFactory =
      _dependencies.replyInfoFactory;
  late final ShortInfoFactory _shortInfoFactory =
      _dependencies.shortInfoFactory;

  @override
  void initState() {
    _bloc.dispatchModel(widget.model);
    super.initState();
  }

  @override
  void didUpdateWidget(covariant MessageAnimationScope oldWidget) {
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
    required _MessageAnimationScopeState holderState,
  }) : _state = holderState;

  final _MessageAnimationScopeState _state;

  static _MessageAnimationScopeState of(BuildContext context) {
    final _MessageAnimationScopeState? result = (context
            .getElementForInheritedWidgetOfExactType<_InheritedScope>()
            ?.widget as _InheritedScope?)
        ?._state;
    assert(result != null, 'No MessageAnimationScope found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(_InheritedScope oldWidget) => false;
}
