import 'package:flutter/material.dart';

class PopupMenuArea<T> extends StatefulWidget {
  const PopupMenuArea({
    super.key,
    required this.child,
    required this.onSelected,
    required this.onTap,
  });

  final Widget child;
  final PopupMenuItemSelected<T> onSelected;
  final void Function(void Function(List<PopupMenuEntry<T>> items)) onTap;

  @override
  State<PopupMenuArea<T>> createState() => _PopupMenuAreaState<T>();
}

class _PopupMenuAreaState<T> extends State<PopupMenuArea<T>> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapUp: (TapUpDetails details) {
        widget.onTap.call(
          (List<PopupMenuEntry<T>> items) {
            if (items.isNotEmpty) {
              _show(context, details.globalPosition, items);
            }
          },
        );
      },
      child: ColoredBox(
        color: Colors.transparent,
        child: widget.child,
      ),
    );
  }

  void _show(
    BuildContext context,
    Offset tapPosition,
    List<PopupMenuEntry<T>> items,
  ) {
    final PopupMenuThemeData popupMenuTheme = PopupMenuTheme.of(context);
    final RenderBox overlay =
        Navigator.of(context).overlay!.context.findRenderObject()! as RenderBox;
    final RelativeRect position = RelativeRect.fromLTRB(
      tapPosition.dx,
      tapPosition.dy,
      overlay.size.width - tapPosition.dx,
      overlay.size.height - tapPosition.dy,
    );
    if (items.isNotEmpty) {
      showMenu<T>(
        context: context,
        items: items,
        initialValue: null,
        position: position,
        shape: popupMenuTheme.shape,
        color: popupMenuTheme.color,
      ).then<void>((T? newValue) {
        if (!mounted || newValue == null) {
          return null;
        }
        widget.onSelected.call(newValue);
      });
    }
  }
}
