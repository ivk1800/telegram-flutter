import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:tile/tile.dart';

import 'chat_screen.dart';
import 'message_factory.dart';
import 'messages_bundle.dart';

class MessagesList extends StatefulWidget {
  const MessagesList({
    super.key,
    required this.messagesBundle,
  });

  final IMessagesBundle messagesBundle;

  @override
  State<MessagesList> createState() => _MessagesListState();
}

class _MessagesListState extends State<MessagesList> {
  final ScrollController _scrollController = ScrollController();
  bool _scrolledToOldest = false;

  ChatMessagesViewModel? _viewModel;

  @override
  void initState() {
    _scrollController.addListener(() {
      if (!_scrolledToOldest && _scrollController.position.extentAfter < 300) {
        _scrolledToOldest = true;
        _viewModel?.onLoadOldestMessages();
      } else if (_scrolledToOldest &&
          _scrollController.position.extentAfter >= 300) {
        _scrolledToOldest = false;
      }
    });
    super.initState();
  }

  @override
  void didChangeDependencies() {
    _viewModel = ChatScreenScope.getChatMessagesViewModel(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final MessageFactory messageFactory =
        ChatScreenScope.getMessageFactory(context);

    return Scrollbar(
      child: ListView.custom(
        controller: _scrollController,
        reverse: true,
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
        childrenDelegate: SliverChildBuilderDelegate(
          (BuildContext context, int index) {
            final int itemIndex = index ~/ 2;
            final Widget widget;
            if (index.isEven) {
              final ITileModel tileModel =
                  this.widget.messagesBundle[itemIndex];
              widget = messageFactory.create(
                context: context,
                model: tileModel,
              );
              // widget = itemBuilder(context, itemIndex);
            } else {
              widget = const SizedBox(height: 8.0);
              // widget = separatorBuilder(context, itemIndex);
            }
            return widget;
          },
          childCount: _computeActualChildCount(widget.messagesBundle.length),
          findChildIndexCallback: (Key key) {
            if (key is ValueKey<int>) {
              return widget.messagesBundle.indexOf(key.value);
            }
            return null;
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  static int _computeActualChildCount(int itemCount) {
    return math.max(0, itemCount * 2 - 1);
  }
}
