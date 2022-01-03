import 'package:coreui/coreui.dart' as tg;
import 'package:feature_create_new_chat_impl/src/screen/new_chat/new_chat_view_model.dart';
import 'package:flutter/material.dart';
import 'package:localization_api/localization_api.dart';
import 'package:provider/provider.dart';

class NewChatPage extends StatefulWidget {
  const NewChatPage({Key? key}) : super(key: key);

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
  const _Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ILocalizationManager localizationManager = context.read();
    final NewChatViewModel viewModel = context.read();

    return Column(
      children: <Widget>[
        tg.TextCell(
          onTap: viewModel.onNewGroupTap,
          leading: const Icon(Icons.circle),
          title: localizationManager.getString('NewGroup'),
        ),
        tg.TextCell(
          onTap: viewModel.onNewSecretChatTap,
          leading: const Icon(Icons.circle),
          title: localizationManager.getString('NewSecretChat'),
        ),
        tg.TextCell(
          onTap: viewModel.onNewChannelTap,
          leading: const Icon(Icons.circle),
          title: localizationManager.getString('NewChannel'),
        )
      ],
    );
  }
}
