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
  Action({required this.text, this.callback});

  final String text;

  final bool Function()? callback;
}
