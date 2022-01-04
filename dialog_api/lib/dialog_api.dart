library dialog_api;

import 'src/body.dart';

export 'src/body.dart';

abstract class IDialogRouter {
  void toDialog({
    String? title,
    required Body body,
    List<Action> actions = const <Action>[],
  });
}

class Action {
  Action({
    required this.text,
    this.callback,
    this.type = ActionType.simple,
  });

  final String text;
  final ActionType type;

  final void Function(IDismissible dismissible)? callback;
}

enum ActionType { simple, attention }

abstract class IDismissible {
  void dismiss();
}

extension DialogRouterExt on IDialogRouter {
  void toNotImplemented() {
    toDialog(
        body: const Body.text(text: 'not implemented :('),
        actions: <Action>[
          Action(text: 'OK'),
        ]);
  }
}
