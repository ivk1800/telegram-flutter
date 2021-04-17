import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:presentation/src/demo/demo_fle_repository.dart';
import 'package:presentation/src/model/model.dart';
import 'package:presentation/src/tile/chat_tile.dart';
import 'package:presentation/src/widget/factory/avatar_widget_factory.dart';

class DemoChatListPage extends StatefulWidget {
  @override
  _DemoChatListPageState createState() => _DemoChatListPageState();
}

class _DemoChatListPageState extends State<DemoChatListPage>
    implements ChatTileListener {
  final List<ChatTileModel> _models = <ChatTileModel>[
    ChatTileModel(
        id: 1,
        unreadMessagesCount: 0,
        isPinned: true,
        lastMessageDate: '20:12',
        title: const TextSpan(text: 'title'),
        subtitle: const TextSpan(text: 'subtitle')),
    ChatTileModel(
        id: 2,
        unreadMessagesCount: 0,
        isPinned: false,
        lastMessageDate: '20:12',
        title: const TextSpan(text: 'title'),
        subtitle: const TextSpan(text: 'subtitle')),
    ChatTileModel(
        id: 3,
        unreadMessagesCount: 10,
        isPinned: false,
        lastMessageDate: '20:12',
        title: const TextSpan(text: 'title'),
        subtitle: const TextSpan(text: 'subtitle'))
  ];
  late ChatTileFactory _chatTileFactory;

  @override
  void initState() {
    super.initState();
    final AvatarWidgetFactory avatarWidgetFactory =
        AvatarWidgetFactory(fileRepository: DemoFileRepository());
    _chatTileFactory = ChatTileFactory(
        listener: this, avatarWidgetFactory: avatarWidgetFactory);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('chats'),
      ),
      body: ListView.builder(
        itemCount: _models.length,
        itemBuilder: (BuildContext context, int index) {
          final ChatTileModel chatTileModel = _models[index];
          return _chatTileFactory.create(context, chatTileModel);
        },
      ),
    );
  }

  @override
  void onChatTap(int id) {
    // TODO: implement onChatTap
  }

  @override
  void onTogglePinTap(int id) {
    // TODO: implement onTogglePinTap
  }
}
