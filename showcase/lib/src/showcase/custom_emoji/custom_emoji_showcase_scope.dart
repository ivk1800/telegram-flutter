import 'package:emoji_ui_kit/emoji_ui_kit.dart';
import 'package:flutter/widgets.dart';

class CustomEmojiShowcaseScope extends StatefulWidget {
  const CustomEmojiShowcaseScope({
    super.key,
    required this.child,
    required this.create,
  });

  final Widget child;
  final ScopeData Function() create;

  @override
  State<CustomEmojiShowcaseScope> createState() =>
      _CustomEmojiShowcaseScopeState();

  static CustomEmojiWidgetFactory getCustomEmojiWidgetFactory(
    BuildContext context,
  ) =>
      _InheritedScope.of(context)._data.customEmojiWidgetFactory;
}

class _CustomEmojiShowcaseScopeState extends State<CustomEmojiShowcaseScope> {
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
    required _CustomEmojiShowcaseScopeState holderState,
  }) : _state = holderState;

  final _CustomEmojiShowcaseScopeState _state;

  static _CustomEmojiShowcaseScopeState of(BuildContext context) {
    final _CustomEmojiShowcaseScopeState? result = (context
            .getElementForInheritedWidgetOfExactType<_InheritedScope>()
            ?.widget as _InheritedScope?)
        ?._state;
    assert(result != null, 'No CustomEmojiShowcaseScope found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(_InheritedScope oldWidget) => false;
}
