import 'package:coreui/coreui.dart';
import 'package:feature_chat_impl/src/screen/chat/bloc/chat_bloc.dart';
import 'package:feature_chat_impl/src/screen/chat/bloc/chat_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

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
    final ConnectionStateWidgetFactory connectionStateWidgetFactory =
        Provider.of(context);
    return Scaffold(
      backgroundColor: Colors.lightBlue,
      appBar: AppBar(
        title: connectionStateWidgetFactory.create(
            context, (_) => const Text('Chat')),
      ),
      body: BlocBuilder<ChatBloc, ChatState>(
          builder: (BuildContext context, ChatState state) {
        switch (state.runtimeType) {
          case DefaultState:
            {
              return _buildMessagesState(context, state as DefaultState);
            }
        }

        return const Center(child: CircularProgressIndicator());
      }),
    );
  }

  Widget _buildMessagesState(BuildContext context, DefaultState state) {
    final ListAdapter listAdapter = Provider.of(context);
    return Scrollbar(
      child: ListView.builder(
        controller: scrollController,
        reverse: true,
        itemCount: state.tiles.length,
        itemBuilder: (BuildContext context, int index) {
          final ITileModel tileModel = state.tiles[index];
          return listAdapter.create(context, tileModel);
        },
      ),
    );
  }
}
