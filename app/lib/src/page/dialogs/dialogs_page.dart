import 'package:flutter/material.dart';
import 'package:presentation/src/model/tile/tile.dart';
import 'package:presentation/src/tile/tile.dart';
import 'package:presentation/src/di/component/screen/chats_list_screen_component.dart';
import 'package:jugger/jugger.dart' as j;

import 'dialogs_view_model.dart';

class DialogsPage extends StatefulWidget {
  const DialogsPage({Key? key}) : super(key: key);

  @override
  DialogsPageState createState() => DialogsPageState();
}

class DialogsPageState extends State<DialogsPage> implements ChatTileListener {
  @j.inject
  late ChatTileFactory chatTileFactory;

  @j.inject
  late DialogsViewModel viewModel;

  @override
  void initState() {
    inject();
    super.initState();
  }

  @override
  void dispose() {
    viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<List<ChatTileModel>>(
        stream: viewModel.chats,
        initialData: const <ChatTileModel>[],
        builder: (BuildContext context,
            AsyncSnapshot<List<ChatTileModel>?> snapshot) {
          final List<ChatTileModel> chats =
              snapshot.data ?? const <ChatTileModel>[];

          return ListView.separated(
            separatorBuilder: (BuildContext context, int index) {
              return Divider(indent: 72, height: 0, color: Colors.grey[400]);
            },
            itemCount: chats.length,
            itemBuilder: (BuildContext context, int index) {
              return chatTileFactory.create(context, chats[index]);
            },
          );
        },
      ),
    );
  }

  @override
  void onChatTap(int id) => viewModel.onChatTap(id);

  @override
  void onTogglePinTap(int id) => viewModel.onChatPinToggleTap(id);
}
