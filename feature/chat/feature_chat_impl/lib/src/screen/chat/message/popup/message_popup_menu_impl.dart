import 'package:flutter/material.dart';

import 'message_popup_menu.dart';

class MessagePopupMenuImpl implements IMessagePopupMenu {
  final void Function(List<PopupMenuEntry<ItemAction>> items) onShow;

  List<MessagePopupMenuItem>? _items;

  MessagePopupMenuImpl({required this.onShow});

  @override
  void setItems(List<MessagePopupMenuItem> items) {
    _items = items;
  }

  @override
  void show() {
    // todo check mounted
    assert(_items != null);

    if (_items!.isEmpty) {
      // todo add log
      return;
    }

    onShow.call(
      _items!.map((MessagePopupMenuItem e) {
        return PopupMenuItem<ItemAction>(
          value: e.action,
          child: Row(
            children: <Widget>[
              const Icon(Icons.circle),
              const SizedBox(width: 8),
              Text(e.text),
            ],
          ),
        );
      }).toList(),
    );
  }
}
