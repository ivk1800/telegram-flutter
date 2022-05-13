import 'package:feature_chat_impl/src/resolver/message_component_resolver.dart';
import 'package:feature_chat_impl/src/tile/model/base_conversation_message_tile_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:tile/tile.dart';

class MessageFactory {
  const MessageFactory({
    required MessageComponentResolver messageComponentResolver,
    required TileFactory tileFactory,
  })  : _messageComponentResolver = messageComponentResolver,
        _tileFactory = tileFactory;

  final MessageComponentResolver _messageComponentResolver;
  final TileFactory _tileFactory;

  Widget create({
    required BuildContext context,
    required ITileModel model,
  }) {
    if (model is BaseConversationMessageTileModel) {
      return _Leading(
        leading: _messageComponentResolver.resolveAvatar(context, model),
        body: _tileFactory.create(context, model),
      );
    }

    return _Leading(
      leading: null,
      body: _tileFactory.create(context, model),
    );
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
