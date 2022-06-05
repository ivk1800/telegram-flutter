import 'package:jugger/jugger.dart' as j;
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import 'chat_screen.dart';
import 'messages_scroll_controller.dart';

@j.singleton
class ChatWidgetModel {
  @j.inject
  ChatWidgetModel({
    required ChatMessagesViewModel viewModel,
  }) {
    final Stream<int> itemsCountStream = viewModel.bodyStateStream
        .where((BodyState event) => event is BodyData)
        .cast<BodyData>()
        .map((BodyData data) => data.models.length);
    _messagesScrollController = MessagesScrollController(
      onScrollToNewest: viewModel.onLoadNewestMessages,
      onScrollToOldest: viewModel.onLoadOldestMessages,
      itemsCountStream: itemsCountStream,
      itemPositions: itemPositionsListener.itemPositions,
    )..attach();
  }

  final ItemScrollController itemScrollController = ItemScrollController();
  final ItemPositionsListener itemPositionsListener =
      ItemPositionsListener.create();

  late MessagesScrollController _messagesScrollController;

  void dispose() {
    _messagesScrollController.dispose();
  }
}
