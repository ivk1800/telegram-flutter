import 'package:flutter/material.dart';

import 'message_popup_listener.dart';
import 'message_popup_menu.dart';
import 'message_popup_menu_impl.dart';
import 'popup_menu_area.dart';

class MessagePopupMenuArea extends StatefulWidget {
  const MessagePopupMenuArea({
    super.key,
    required this.child,
    required this.listener,
    required this.messageId,
  });

  final Widget child;
  final IMessagePopupMenuListener listener;
  final int messageId;

  @override
  State<MessagePopupMenuArea> createState() => _MessagePopupMenuAreaState();
}

class _MessagePopupMenuAreaState extends State<MessagePopupMenuArea> {
  @override
  Widget build(BuildContext context) {
    return PopupMenuArea<ItemAction>(
      // ignore: always_specify_types
      onTap: (show) {
        final MessagePopupMenuImpl popupMenu =
            MessagePopupMenuImpl(onShow: show);
        widget.listener.onWillShowPopupMenu(widget.messageId, popupMenu);
      },
      onSelected: widget.listener.onItemSelected,
      child: ColoredBox(
        color: Colors.transparent,
        child: widget.child,
      ),
    );
  }
}
