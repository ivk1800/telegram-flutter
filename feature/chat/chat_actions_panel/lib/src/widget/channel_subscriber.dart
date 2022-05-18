import 'package:flutter/material.dart';
import 'package:localization_api/localization_api.dart';

import '../chat_action_panel_scope.dart';
import '../panel_state.dart';
import 'chat_action_panel.dart';

class ChannelSubscriber extends StatelessWidget {
  const ChannelSubscriber({
    super.key,
    required this.state,
  });

  final ChannelSubscriberState state;

  @override
  Widget build(BuildContext context) {
    final IStringsProvider stringsProvider =
        ChatActionPanelScope.getStringsProvider(context);

    return TextButton(
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(double.infinity, kPanelHeight),
      ),
      onPressed: () {
        ChatActionPanelScope.getChatActionsPanelViewModel(context)
            .onToggleMuteState(
          newState: !state.isMuted,
        );
      },
      child: Text(
        state.isMuted
            ? stringsProvider.channelUnmute
            : stringsProvider.channelMute,
      ),
    );
  }
}
