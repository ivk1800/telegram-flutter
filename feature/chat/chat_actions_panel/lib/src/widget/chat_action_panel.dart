import 'package:chat_actions_panel/src/chat_action_panel_scope.dart';
import 'package:chat_actions_panel/src/widget/writer.dart';
import 'package:core_arch_flutter/core_arch_flutter.dart';
import 'package:flutter/material.dart';

import '../panel_state.dart';
import 'channel_subscriber.dart';
import 'join.dart';

class ChatActionPanel extends StatelessWidget {
  const ChatActionPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: const Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Divider(height: 1),
          LimitedBox(
            maxHeight: kPanelHeight,
            child: _Content(),
          ),
          // textButton()
          // buildRow()
        ],
      ),
    );
  }
}

class _Content extends StatelessWidget {
  const _Content();

  @override
  Widget build(BuildContext context) {
    return StreamListener<PanelState>(
      stream: ChatActionPanelScope.getChatActionsPanelViewModel(context)
          .actionsPanelState,
      builder: (BuildContext context, PanelState state) {
        return state.map(
          join: (JoinState value) {
            return Join(state: value);
          },
          empty: (EmptyState state) {
            return const SizedBox.expand();
          },
          channelSubscriber: (ChannelSubscriberState state) {
            return ChannelSubscriber(state: state);
          },
          writer: (WriterState state) {
            return Writer(state: state);
          },
        );
      },
    );
  }
}

const double kPanelHeight = 50;
