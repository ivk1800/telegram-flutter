import 'package:chat_list_theme/chat_list_theme.dart';
import 'package:flutter/material.dart';

class ChatHeightProvider extends StatefulWidget {
  const ChatHeightProvider({super.key, required this.child});

  final Widget child;

  @override
  State<ChatHeightProvider> createState() => _ChatHeightProviderState();

  static double getValue(BuildContext context) {
    final CellHeightModel? heightModel =
        InheritedModel.inheritFrom<CellHeightModel>(context);
    assert(heightModel != null);
    assert(heightModel!.value > 0);
    return heightModel!.value;
  }
}

class _ChatHeightProviderState extends State<ChatHeightProvider> {
  late double _value;

  @override
  Widget build(BuildContext context) {
    return CellHeightModel(value: _value, child: widget.child);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final ChatCellTheme chatCellTheme =
        Theme.of(context).extension<ChatCellTheme>()!;

    final double titleHeight = _calculateHeight(chatCellTheme.titleStyle);
    final double subtitleHeight = _calculateHeight(chatCellTheme.subtitleStyle);
    final double secondarySubtitleHeight =
        _calculateHeight(chatCellTheme.secondarySubtitleStyle);
    final double height = (ChatCellTheme.kVerticalSpace * 2) +
        (titleHeight + subtitleHeight + secondarySubtitleHeight) +
        ChatCellTheme.kTitleBottomSpace;

    setState(() {
      _value = height;
    });
  }

  double _calculateHeight(TextStyle style) {
    return (TextPainter(
          text: TextSpan(
            text: '✅',
            style: style,
          ),
          maxLines: 1,
          textDirection: TextDirection.ltr,
        )..layout())
            .size
            .height *
        (style.height ?? 1.0);
  }
}

class CellHeightModel extends InheritedModel<Object> {
  const CellHeightModel({
    super.key,
    required this.value,
    required super.child,
  });

  final double value;

  @override
  bool updateShouldNotify(covariant CellHeightModel oldWidget) {
    return value != oldWidget.value;
  }

  @override
  bool updateShouldNotifyDependent(
    covariant CellHeightModel oldWidget,
    Set<Object> dependencies,
  ) {
    return value != oldWidget.value;
  }
}
