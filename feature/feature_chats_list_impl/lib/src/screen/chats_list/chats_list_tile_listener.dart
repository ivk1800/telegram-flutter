import 'package:feature_chats_list_impl/src/tile/chat_tile.dart';

import 'chats_list_view_model.dart';

class ChatsListTileListener implements ChatTileListener {
  const ChatsListTileListener({
    required ChatsListViewModel viewModel,
  }) : _viewModel = viewModel;

  final ChatsListViewModel _viewModel;

  @override
  void onChatTap(int id) {
    _viewModel.onChatTap(id);
  }

  @override
  void onTogglePinTap(int id) {
    // TODO: implement onTogglePinTap
  }
}
