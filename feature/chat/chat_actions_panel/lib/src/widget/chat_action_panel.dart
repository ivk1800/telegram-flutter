import 'package:chat_actions_panel/src/chat_action_panel_scope.dart';
import 'package:chat_actions_panel/src/chat_actions_panel_view_model.dart';
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
    final ChatActionsPanelViewModel viewModel =
        ChatActionPanelScope.getChatActionsPanelViewModel(context);

    return ConstrainedBox(
      constraints: const BoxConstraints(minHeight: kPanelHeight + 1),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          const Divider(height: 1),
          StreamListener<PanelState>(
            stream: viewModel.actionsPanelState,
            builder: (BuildContext c, PanelState state) {
              return state.map(
                join: (JoinState value) {
                  return Join(state: value);
                },
                empty: (EmptyState state) {
                  return const SizedBox.shrink();
                },
                channelSubscriber: (ChannelSubscriberState state) {
                  return ChannelSubscriber(state: state);
                },
                writer: (WriterState state) {
                  return Writer(state: state);
                },
              );
            },
          ),
          // textButton()
          // buildRow()
        ],
      ),
    );
  }
}

const double kPanelHeight = 50;
