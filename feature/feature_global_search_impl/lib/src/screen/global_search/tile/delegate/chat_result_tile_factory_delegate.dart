import 'package:coreui/coreui.dart';
import 'package:feature_global_search_impl/src/screen/global_search/tile/model/chat_result_tile_model.dart';
import 'package:flutter/material.dart';
import 'package:tile/tile.dart';

typedef ChatResultTapCallback = void Function(BuildContext context, int chatId);

class ChatResultTileFactoryDelegate
    implements ITileFactoryDelegate<ChatResultTileModel> {
  const ChatResultTileFactoryDelegate({
    required AvatarWidgetFactory avatarWidgetFactory,
    required ChatResultTapCallback onTap,
  })  : _avatarWidgetFactory = avatarWidgetFactory,
        _onTap = onTap;

  final AvatarWidgetFactory _avatarWidgetFactory;
  final ChatResultTapCallback _onTap;

  @override
  Widget create(BuildContext context, ChatResultTileModel model) {
    return ListTile(
      onTap: () => _onTap.call(context, model.chatId),
      leading: _avatarWidgetFactory.create(
        context,
        chatId: model.chatId,
        imageId: model.avatarId,
      ),
      title: Text.rich(
        model.title,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      subtitle: Text.rich(model.subtitle),
    );
  }
}
