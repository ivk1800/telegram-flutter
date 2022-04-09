class AvailableActionsState {
  AvailableActionsState({this.deleteChat});

  final DeleteChat? deleteChat;
}

// delete chat button
class DeleteChat {
  DeleteChat({required this.text});

  final String text;
}
