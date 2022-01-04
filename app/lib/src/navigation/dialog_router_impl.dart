import 'package:dialog_api/dialog_api.dart';
import 'package:dialog_api/dialog_api.dart' as dialog_api;
import 'package:flutter/material.dart';

class DialogRouterImpl implements IDialogRouter {
  DialogRouterImpl({
    required GlobalKey<NavigatorState> dialogNavigatorKey,
  }) : _dialogNavigatorKey = dialogNavigatorKey;

  final GlobalKey<NavigatorState> _dialogNavigatorKey;

  @override
  void toDialog({
    String? title,
    required Body body,
    List<dialog_api.Action> actions = const <dialog_api.Action>[],
  }) {
    Widget? createContent() {
      return body.when(
        text: (String text) {
          return Text(text);
        },
      );
    }

    _showDialog(
      builder: (BuildContext context) {
        Color? getActionColor(dialog_api.ActionType type) {
          switch (type) {
            case dialog_api.ActionType.simple:
              return null;
            case dialog_api.ActionType.attention:
              return Theme.of(context).errorColor;
          }
        }

        return AlertDialog(
          title: title != null ? Text(title) : null,
          content: createContent(),
          actions: actions
              .map((dialog_api.Action action) => TextButton(
                    child: Text(
                      action.text,
                      style: TextStyle(color: getActionColor(action.type)),
                    ),
                    onPressed: () {
                      if (action.callback == null) {
                        Navigator.of(context).pop();
                      } else {
                        action.callback!.call(_Dismissible(context: context));
                      }
                    },
                  ))
              .toList(),
        );
      },
    );
  }

  void _showDialog({required WidgetBuilder builder}) {
    final BuildContext? context = _dialogNavigatorKey.currentContext;

    if (context == null) {
      return;
    }

    showDialog<dynamic>(
      context: context,
      builder: builder,
    );
  }
}

class _Dismissible implements IDismissible {
  _Dismissible({required this.context});

  final BuildContext context;

  @override
  void dismiss() {
    Navigator.of(context).pop();
  }
}
