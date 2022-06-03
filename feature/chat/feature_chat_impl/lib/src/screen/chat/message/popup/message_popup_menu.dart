abstract class IMessagePopupMenu {
  void setItems(List<MessagePopupMenuItem> items);
  void show();
}

class MessagePopupMenuItem {
  const MessagePopupMenuItem({
    required this.text,
    required this.action,
  });

  final String text;
  final ItemAction action;
}

enum ItemAction {
  reply,
  copy,
  copyLink,
  forward,
  report,
  delete,
}
