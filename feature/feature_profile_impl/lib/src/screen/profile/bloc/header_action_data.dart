class HeaderActionData {
  HeaderActionData({
    required this.action,
    required this.label,
  });

  final HeaderAction action;

  final String label;
}

enum HeaderAction {
  edit,
}
