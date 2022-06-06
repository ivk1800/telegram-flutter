import 'package:feature_chat_impl/src/resolver/message_component_resolver.dart';
import 'package:feature_chat_impl/src/tile/model/base_conversation_message_tile_model.dart';
import 'package:feature_chat_impl/src/tile/model/base_message_tile_model.dart';
import 'package:flutter/material.dart';
import 'package:tile/tile.dart';

import 'interactable_message_factory.dart';
import 'message/popup/message_popup_listener.dart';
import 'message/popup/message_popup_menu_area.dart';

class MessageFactory implements IInteractableMessageFactory {
  const MessageFactory({
    required MessageComponentResolver messageComponentResolver,
    required TileFactory tileFactory,
    required IMessagePopupMenuListener popupMenuListener,
  })  : _messageComponentResolver = messageComponentResolver,
        _popupMenuListener = popupMenuListener,
        _tileFactory = tileFactory;

  final MessageComponentResolver _messageComponentResolver;
  final TileFactory _tileFactory;
  final IMessagePopupMenuListener _popupMenuListener;

  @override
  Widget create({
    required BuildContext context,
    required ITileModel model,
  }) {
    if (model is BaseConversationMessageTileModel) {
      return MessagePopupMenuArea(
        key: ValueKey<int>(model.id),
        messageId: model.id,
        listener: _popupMenuListener,
        child: _Leading(
          leading: _messageComponentResolver.resolveAvatar(context, model),
          body: _tileFactory.create(context, model),
        ),
      );
    }

    if (model is BaseMessageTileModel) {
      return MessagePopupMenuArea(
        key: ValueKey<int>(model.id),
        messageId: model.id,
        listener: _popupMenuListener,
        child: _Leading(
          leading: null,
          body: _tileFactory.create(context, model),
        ),
      );
    }

    return _tileFactory.create(context, model);
  }
}

class _Leading extends StatelessWidget {
  const _Leading({
    required this.leading,
    required this.body,
  });

  final Widget? leading;
  final Widget body;

  @override
  Widget build(BuildContext context) {
    if (leading == null) {
      return body;
    }

    return Row(
      // todo need pass from args for different cases
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[leading!, Flexible(child: body)],
    );
  }
}
