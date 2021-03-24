import 'package:flutter/material.dart';
import 'package:presentation/src/di/component/screen/chat_screen_component.dart';
import 'package:jugger/jugger.dart' as j;
import 'package:presentation/src/tile/chat_message/chat_message.dart';
import 'package:presentation/src/tile/tile.dart';
import 'package:tdlib/td_api.dart' as td;

import 'chat_view_model.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({Key? key, required this.chatId}) : super(key: key);

  final int chatId;

  @override
  ChatPageState createState() => ChatPageState();
}

class ChatPageState extends State<ChatPage> {
  @j.inject
  late ChatMessageTileFactory chatMessageTileFactory;

  final ScrollController scrollController = ScrollController();

  @j.inject
  late ChatViewModel viewModel;

  @override
  void initState() {
    inject();
    super.initState();

    scrollController.addListener(() {
      final double extentAfter = scrollController.position.extentAfter;
      if (extentAfter < 200) {
        viewModel.onScroll();
      }
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat'),
      ),
      body: StreamBuilder<List<td.Message>>(
        stream: viewModel.messages,
        initialData: const <td.Message>[],
        builder:
            (BuildContext context, AsyncSnapshot<List<td.Message>?> snapshot) {
          final List<td.Message> messages =
              snapshot.data ?? const <td.Message>[];

          return Scrollbar(
            child: ListView.builder(
              controller: scrollController,
              reverse: true,
              itemCount: messages.length,
              itemBuilder: (BuildContext context, int index) {
                return chatMessageTileFactory.create(context, messages[index]);
              },
            ),
          );
        },
      ),
    );
  }
}
