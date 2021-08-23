import 'package:feature_chat_header_info_api/feature_chat_header_info_api.dart';
import 'package:feature_chat_impl/src/screen/chat/bloc/chat_bloc.dart';
import 'package:feature_chat_impl/src/screen/chat/bloc/chat_event.dart';
import 'package:feature_chat_impl/src/widget/chat_context.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:tile/tile.dart';

import 'bloc/chat_state.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  ChatPageState createState() => ChatPageState();
}

class ChatPageState extends State<ChatPage> {
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    scrollController.addListener(() {
      final double extentAfter = scrollController.position.extentAfter;
      if (extentAfter < 200) {
        Provider.of<ChatBloc>(context, listen: false).add(const ScrollEvent());
      }
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final IChatHeaderInfoFactory chatHeaderInfoFactory = Provider.of(context);

    return BlocBuilder<ChatBloc, ChatState>(
        builder: (BuildContext context, ChatState state) {
      return Scaffold(
        backgroundColor: Colors.lightBlue,
        appBar: AppBar(
          titleSpacing: 0.0,
          title: chatHeaderInfoFactory.create(
              context: context, info: state.headerState.info),
        ),
        body: Builder(builder: (BuildContext context) {
          switch (state.bodyState.runtimeType) {
            case DataBodyState:
              {
                return _wrapToChatContext(
                    child: _buildMessagesState(
                        context, state.bodyState as DataBodyState));
              }
          }

          return const Center(child: CircularProgressIndicator());
        }),
      );
    });
  }

  Widget _wrapToChatContext({required Widget child}) => LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return ChatContext(
              data: ChatContextData.desktop(maxWidth: constraints.maxWidth),
              child: child);
        },
      );

  Widget _buildMessagesState(BuildContext context, DataBodyState state) {
    final TileFactory tileFactory = Provider.of(context);
    return Scrollbar(
      child: ListView.builder(
        // todo extract to config
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
        controller: scrollController,
        reverse: true,
        itemCount: state.tiles.length,
        itemBuilder: (BuildContext context, int index) {
          final ITileModel tileModel = state.tiles[index];
          return tileFactory.create(context, tileModel);
        },
      ),
    );
  }
}
