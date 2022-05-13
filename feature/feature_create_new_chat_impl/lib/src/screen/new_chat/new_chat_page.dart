import 'package:coreui/coreui.dart' as tg;
import 'package:feature_create_new_chat_impl/src/screen/new_chat/new_chat.dart';
import 'package:flutter/material.dart';
import 'package:localization_api/localization_api.dart';

class NewChatPage extends StatefulWidget {
  const NewChatPage({super.key});

  @override
  State<NewChatPage> createState() => _NewChatPageState();
}

class _NewChatPageState extends State<NewChatPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const _Body(),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body();

  @override
  Widget build(BuildContext context) {
    final IStringsProvider stringsProvider =
        NewChatScreenScope.getStringsProvider(context);
    final NewChatViewModel viewModel =
        NewChatScreenScope.getNewChatViewModel(context);

    return Column(
      children: <Widget>[
        tg.TextCell(
          onTap: viewModel.onNewGroupTap,
          leading: const Icon(Icons.circle),
          title: stringsProvider.newGroup,
        ),
        tg.TextCell(
          onTap: viewModel.onNewSecretChatTap,
          leading: const Icon(Icons.circle),
          title: stringsProvider.newSecretChat,
        ),
        tg.TextCell(
          onTap: viewModel.onNewChannelTap,
          leading: const Icon(Icons.circle),
          title: stringsProvider.newChannel,
        ),
      ],
    );
  }
}
