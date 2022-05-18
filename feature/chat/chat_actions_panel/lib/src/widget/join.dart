import 'package:chat_actions_panel/src/chat_action_panel_scope.dart';
import 'package:flutter/material.dart';
import 'package:localization_api/localization_api.dart';

import '../panel_state.dart';
import 'chat_action_panel.dart';

class Join extends StatelessWidget {
  const Join({
    super.key,
    required this.state,
  });

  final JoinState state;

  @override
  Widget build(BuildContext context) {
    final IStringsProvider stringsProvider =
        ChatActionPanelScope.getStringsProvider(context);

    return TextButton(
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(double.infinity, kPanelHeight),
      ),
      onPressed: () =>
          ChatActionPanelScope.getChatActionsPanelViewModel(context).onJoin(),
      child: Text(stringsProvider.channelJoin),
    );
  }
}
