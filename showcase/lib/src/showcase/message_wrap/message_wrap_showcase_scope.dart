import 'package:emoji_ui_kit/emoji_ui_kit.dart';
import 'package:flutter/widgets.dart';

class MessageWrapShowcaseScope extends StatefulWidget {
  const MessageWrapShowcaseScope({
    super.key,
    required this.child,
    required this.create,
  });

  final Widget child;
  final ScopeData Function() create;

  @override
  State<MessageWrapShowcaseScope> createState() =>
      _MessageWrapShowcaseScopeState();

  static CustomEmojiWidgetFactory getCustomEmojiWidgetFactory(
    BuildContext context,
  ) =>
      _InheritedScope.of(context)._data.customEmojiWidgetFactory;
}

class _MessageWrapShowcaseScopeState extends State<MessageWrapShowcaseScope> {
  late final ScopeData _data = widget.create.call();

  @override
  Widget build(BuildContext context) {
    return _InheritedScope(
      holderState: this,
      child: widget.child,
    );
  }
}

class ScopeData {
  ScopeData({required this.customEmojiWidgetFactory});

  final CustomEmojiWidgetFactory customEmojiWidgetFactory;
}

class _InheritedScope extends InheritedWidget {
  const _InheritedScope({
    required super.child,
    required _MessageWrapShowcaseScopeState holderState,
  }) : _state = holderState;

  final _MessageWrapShowcaseScopeState _state;

  static _MessageWrapShowcaseScopeState of(BuildContext context) {
    final _MessageWrapShowcaseScopeState? result = (context
            .getElementForInheritedWidgetOfExactType<_InheritedScope>()
            ?.widget as _InheritedScope?)
        ?._state;
    assert(result != null, 'No MessageWrapShowcaseScope found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(_InheritedScope oldWidget) => false;
}
