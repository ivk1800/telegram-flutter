import 'package:core_arch_flutter/core_arch_flutter.dart';
import 'package:coreui/coreui.dart' as tg;
import 'package:flutter/material.dart';
import 'package:localization_api/localization_api.dart';

import 'available_actions_state.dart';
import 'chat_administration_screen_scope.dart';
import 'chat_administration_view_model.dart';

class ChatAdministrationPage extends StatelessWidget {
  const ChatAdministrationPage({super.key});

  @override
  Widget build(BuildContext context) {
    final IStringsProvider stringsProvider =
        ChatAdministrationScreenScope.getStringsProvider(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(stringsProvider.channelEdit),
      ),
      body: const SingleChildScrollView(child: _Body()),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body();

  @override
  Widget build(BuildContext context) {
    final ChatAdministrationViewModel viewModel =
        ChatAdministrationScreenScope.getChatAdministrationViewModel(context);
    return StreamListener<AvailableActionsState>(
      stream: viewModel.availableActionsState,
      builder: _buildBody,
    );
  }

  Widget _buildBody(BuildContext context, AvailableActionsState state) {
    final ChatAdministrationViewModel viewModel =
        ChatAdministrationScreenScope.getChatAdministrationViewModel(context);
    final DeleteChat? deleteChat = state.deleteChat;
    return Column(
      children: <Widget>[
        if (deleteChat != null) ...<Widget>[
          tg.TextCell(
            onTap: viewModel.onDeleteChatTap,
            title: deleteChat.text,
          ),
          const tg.SectionDivider(),
        ],
      ],
    );
  }
}
