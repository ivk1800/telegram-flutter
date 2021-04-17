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
  late List<ChatTileModel> _models;
  late ChatTileFactory _chatTileFactory;

  @override
  void initState() {
    super.initState();
    _models = _createModels();
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

  List<ChatTileModel> _createModels() => <ChatTileModel>[
        _createModel(id: 1, isPinned: true),
        _createModel(
          id: 2,
        ),
        _createModel(
          id: 3,
          isOfficial: true,
        ),
        _createModel(id: 4, isMuted: true),
        _createModel(
          id: 5,
          isOfficial: true,
          isMuted: true,
        ),
        _createModel(
          id: 6,
        ),
        _createModel(id: 7, firstSubtitle: 'add user')
      ];

  ChatTileModel _createModel({
    bool isPinned = false,
    int id = 0,
    int unreadMessagesCount = 0,
    String? lastMessageDate = '12:43',
    int? photoId,
    bool isOfficial = false,
    bool isMuted = false,
    String title = 'title',
    String? firstSubtitle,
    String? secondSubtitle = _messageText,
  }) {
    return ChatTileModel(
        id: id,
        unreadMessagesCount: unreadMessagesCount,
        isPinned: isPinned,
        isOfficial: isOfficial,
        photoId: photoId,
        isMuted: isMuted,
        lastMessageDate: lastMessageDate,
        title: title,
        firstSubtitle: firstSubtitle,
        secondSubtitle: secondSubtitle);
  }

  static const String _messageText =
      '🎉 More good news – I am happy to share that Telegram has raised over 1 billion by selling bonds (a form of debt) ';
}
