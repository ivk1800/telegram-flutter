import 'package:feature_chats_list_impl/src/tile/chat_tile.dart';
import 'package:feature_chats_list_impl/src/tile/chat_tile_model.dart';
import 'package:flutter/material.dart';
import 'package:jext/jext.dart';
import 'package:jugger/jugger.dart' as j;
import 'chats_list_view_model.dart';

class ChatsListPage extends StatefulWidget {
  const ChatsListPage({Key? key}) : super(key: key);

  @override
  ChatsListPageState createState() => ChatsListPageState();
}

class ChatsListPageState extends State<ChatsListPage>
    with StateInjectorMixin<ChatsListPage, ChatsListPageState>
    implements ChatTileListener {
  @j.inject
  late ChatTileFactory chatTileFactory;

  @j.inject
  late ChatsListViewModel viewModel;

  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
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
      body: StreamBuilder<List<ChatTileModel>>(
        stream: viewModel.chats,
        initialData: const <ChatTileModel>[],
        builder: (
          BuildContext context,
          AsyncSnapshot<List<ChatTileModel>?> snapshot,
        ) {
          final List<ChatTileModel> chats =
              snapshot.data ?? const <ChatTileModel>[];

          return Scrollbar(
            child: ListView.separated(
              controller: scrollController,
              separatorBuilder: (BuildContext context, int index) {
                // todo support dark theme
                return Divider(indent: 72, height: 0, color: Colors.grey[400]);
              },
              itemCount: chats.length,
              itemBuilder: (BuildContext context, int index) {
                return chatTileFactory.create(context, chats[index]);
              },
            ),
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
