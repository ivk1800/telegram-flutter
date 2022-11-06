import 'dart:async';

import 'package:core_presentation/core_presentation.dart';
import 'package:core_utils/core_utils.dart';
import 'package:coreui/coreui.dart';
import 'package:coreui/coreui.dart' as tg;
import 'package:fake/fake.dart';
import 'package:feature_chats_list_impl/feature_chats_list_impl.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ChatCellShowCase extends StatefulWidget {
  const ChatCellShowCase({super.key});

  @override
  State<ChatCellShowCase> createState() => _ChatCellShowCaseState();
}

class _ChatCellShowCaseState extends State<ChatCellShowCase>
    implements IChatTileListener {
  late ChatTileFactory chatTileFactory;
  late List<ChatTileModel> models;

  StreamSubscription<int>? _unreadMessagesCountSubscription;

  @override
  void initState() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    chatTileFactory = ChatTileFactory(
      listener: this,
      avatarWidgetFactory: AvatarWidgetFactory(
        fileDownloader: const FakeFileDownloader(),
      ),
    );
    models = _createModels();
    super.initState();

    int count = 0;
    _unreadMessagesCountSubscription =
        Stream<int>.periodic(const Duration(milliseconds: 400), (_) => count++)
            .listen((int event) {
      setState(() {
        models[1] = models[1].copy(unreadMessagesCount: count);
      });
    });
  }

  @override
  void dispose() {
    _unreadMessagesCountSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ListView listView = ListView.separated(
      itemCount: models.length,
      itemBuilder: (BuildContext context, int index) =>
          chatTileFactory.create(context, models[index]),
      separatorBuilder: (BuildContext context, int index) =>
          const tg.Divider(indent: DividerIndent.large),
    );
    return Scaffold(
      appBar: AppBar(),
      body: ChatHeightProvider(
        child: listView,
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

  List<ChatTileModel> _createModels() {
    return <ChatTileModel>[
      _createModel(
        id: 1,
        title: 'Flutter developers',
        firstSubtitle: 'ivan',
        isMuted: true,
        secondSubtitle: 'hello',
      ),
      _createModel(
        id: 2,
        title: 'Flutter developers',
        secondSubtitle: 'without firstSubtitle',
      ),
      _createModel(
        id: 3,
        title: 'Flutter developers',
        firstSubtitle: 'Without secondSubtitle',
      ),
      _createModel(
        id: 4,
        title: 'Flutter developers',
        firstSubtitle:
            'long firstSubtitle long firstSubtitle long firstSubtitle long firstSubtitle long firstSubtitle long firstSubtitle',
      ),
      _createModel(
        id: 5,
        title: 'Flutter developers',
        secondSubtitle:
            'long secondSubtitle long secondSubtitle long secondSubtitle long secondSubtitle long secondSubtitle long secondSubtitle',
      ),
      _createModel(
        id: 6,
        title: 'Flutter developers',
        secondSubtitle:
            'long secondSubtitle long secondSubtitle long secondSubtitle long secondSubtitle long secondSubtitle long secondSubtitle',
        firstSubtitle:
            'long firstSubtitle long firstSubtitle long firstSubtitle long firstSubtitle long firstSubtitle long firstSubtitle',
      ),
      _createModel(
        id: 7,
        title:
            'long title long title long title long title long title long title',
        secondSubtitle:
            'long secondSubtitle long secondSubtitle long secondSubtitle long secondSubtitle long secondSubtitle long secondSubtitle',
        firstSubtitle:
            'long firstSubtitle long firstSubtitle long firstSubtitle long firstSubtitle long firstSubtitle long firstSubtitle',
      ),
      _createModel(
        id: 8,
        title: 'pinned',
        isPinned: true,
        secondSubtitle: 'hello',
      ),
      _createModel(
        id: 9,
        title: 'muted',
        isMuted: true,
        secondSubtitle: 'hello',
      ),
      _createModel(
        id: 10,
        title: 'verified',
        isVerified: true,
        secondSubtitle: 'hello',
      ),
      _createModel(
        id: 11,
        title: 'verified and muted',
        isMuted: true,
        isVerified: true,
        secondSubtitle: 'hello',
      ),
      _createModel(
        id: 12,
        title: 'mentioned',
        isMentioned: true,
        secondSubtitle: 'hello',
      ),
      _createModel(
        id: 13,
        title: 'unreadMessagesCount',
        unreadMessagesCount: 10,
        secondSubtitle: 'hello',
      ),
      _createModel(
        id: 14,
        title: 'unreadMessagesCount and mentioned',
        unreadMessagesCount: 10,
        secondSubtitle: 'hello',
        isMentioned: true,
      ),
      _createModel(
        id: 15,
        title: 'pinned',
        secondSubtitle: 'hello',
        isPinned: true,
      ),
      _createModel(
        id: 16,
        title: '😃emoji',
        firstSubtitle: '😃emoji',
        secondSubtitle: '😃emoji',
      ),
      _createModel(
        id: 17,
        title: '❌emoji emoji emoji emoji emoji emoji emoji emoji emoji emoji',
        firstSubtitle:
            '😃emoji😃 emoji emoji emoji emoji emoji emoji emoji emoji emoji',
        secondSubtitle:
            '❌emoji emoji emoji emoji emoji emoji emoji emoji emoji emoji',
      ),
      _createModel(
        id: 18,
        title: '❌emoji emoji emoji emoji emoji emoji emoji emoji emoji emoji',
        secondSubtitle:
            '😃emoji emoji emoji emoji emoji emoji emoji ❌emoji emoji emoji',
      ),
      _createModel(
        id: 19,
        title: '❌emoji emoji emoji emoji emoji emoji emoji emoji emoji emoji',
        firstSubtitle:
            '😃😃😃😃emoji emoji emoji emoji emoji emoji emoji ❌emoji emoji emoji',
      ),
      _createModel(
        id: 20,
        isSecret: true,
        title: 'Secret chat',
        firstSubtitle: '😃😃😃😃emoji emoji ',
      ),
      _createModel(
        id: 21,
        isRead: true,
        title: 'Hello',
        firstSubtitle: 'is read',
      ),
      _createModel(
        id: 23,
        isRead: false,
        title: 'Hello',
        firstSubtitle: 'is not read',
      ),
      _createModel(
        id: 24,
        title: 'mentioned and muted',
        unreadMessagesCount: 99,
        isMuted: true,
        secondSubtitle: 'hello',
      ),
      _createModel(
        id: 25,
        unreadMessagesCount: 123456,
        isMentioned: true,
        title: '❌emoji emoji emoji emoji emoji emoji emoji emoji emoji emoji',
        secondSubtitle:
            '😃😃😃😃emoji emoji emoji emoji emoji emoji emoji ❌emoji emoji emoji  emoji ❌emoji emoji emoji',
      ),
      _createModel(
        id: 1,
        title: 'Forum flutter developers',
        firstSubtitle: 'ivan',
        secondSubtitle: 'hello',
        isForum: true,
      ),
    ];
  }

  ChatTileModel _createModel({
    bool? isPinned,
    int? id,
    int? unreadMessagesCount,
    String? lastMessageDate,
    Avatar? avatar,
    bool? isVerified,
    bool? isMentioned,
    bool? isSecret,
    bool? isMuted,
    bool? isRead,
    String? title,
    String? firstSubtitle,
    String? secondSubtitle,
    bool? isForum,
  }) =>
      ChatTileModel(
        isPinned: isPinned ?? false,
        id: id ?? 0,
        isSecret: isSecret ?? false,
        isRead: isRead,
        isMuted: isMuted ?? false,
        isMentioned: isMentioned ?? false,
        isVerified: isVerified ?? false,
        unreadMessagesCount: unreadMessagesCount ?? 0,
        firstSubtitle: firstSubtitle,
        secondSubtitle: secondSubtitle,
        lastMessageDate: lastMessageDate ?? '12:00',
        title: title ?? 'title',
        avatar: avatar ??
            Avatar.simple(
              abbreviation: getAvatarAbbreviation(
                first: title ?? 'title',
                second: '',
              ),
              objectId: id ?? 0,
              imageFileId: null,
            ),
        isForum: isForum ?? false,
      );
}
