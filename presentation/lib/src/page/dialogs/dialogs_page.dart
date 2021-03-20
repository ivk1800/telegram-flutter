import 'package:flutter/material.dart';
import 'package:presentation/presentation.dart';
import 'package:tdlib/td_api.dart' as td;

class DialogsPage extends StatefulWidget {
  const DialogsPage({Key? key}) : super(key: key);

  @override
  AuthPageState createState() => AuthPageState();
}

class AuthPageState extends State<DialogsPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dialogs'),
      ),
      body: StreamBuilder<List<td.Chat>>(
        stream: appComponent.getChatRepository().chats,
        initialData: const <td.Chat>[],
        builder:
            (BuildContext context, AsyncSnapshot<List<td.Chat>?> snapshot) {
          final List<td.Chat> chats = snapshot.data ?? const <td.Chat>[];

          return ListView.builder(
            itemCount: chats.length,
            itemBuilder: (BuildContext context, int index) {
              final td.Chat chat = chats[index];
              return ListTile(
                title: Text(chat.title),
                subtitle: Text(chat.lastMessage?.content.toString() ?? ''),
              );
            },
          );
        },
      ),
    );
  }
}
