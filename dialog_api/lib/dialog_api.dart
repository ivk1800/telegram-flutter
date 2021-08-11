library dialog_api;

abstract class IDialogRouter {
  void toDialog({
    String? title,
    required Body body,
    List<Action> actions = const <Action>[],
  });
}

abstract class Body {}

class TextBody implements Body {
  TextBody({required this.text});

  final String text;
}

class Action {
  Action({
    required this.text,
    this.callback,
    this.type = ActionType.Default,
  });

  final String text;
  final ActionType type;

  final bool Function()? callback;
}

enum ActionType { Default, Attention }
