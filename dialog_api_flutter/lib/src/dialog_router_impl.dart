import 'package:dialog_api/dialog_api.dart' as d;
import 'package:flutter/material.dart';

class DialogRouterImpl implements d.IDialogRouter {
  DialogRouterImpl({
    required GlobalKey<NavigatorState> dialogNavigatorKey,
  }) : _dialogNavigatorKey = dialogNavigatorKey;

  final GlobalKey<NavigatorState> _dialogNavigatorKey;

  @override
  void toDialog({
    String? title,
    required d.Body body,
    List<d.Action> actions = const <d.Action>[],
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
        Color? getActionColor(d.ActionType type) {
          switch (type) {
            case d.ActionType.simple:
              return null;
            case d.ActionType.attention:
              return Theme.of(context).errorColor;
          }
        }

        return AlertDialog(
          title: title != null ? Text(title) : null,
          content: createContent(),
          actions: actions
              .map((d.Action action) => TextButton(
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

class _Dismissible implements d.IDismissible {
  _Dismissible({required this.context});

  final BuildContext context;

  @override
  void dismiss() {
    Navigator.of(context).pop();
  }
}
