import 'package:feature_chat_impl/src/tile/message_sticker/message_sticker.dart';
import 'package:feature_chat_impl/src/tile/message_sticker/message_sticker_bloc.dart';
import 'package:feature_chat_impl/src/tile/message_sticker/message_sticker_dependencies.dart';
import 'package:feature_chat_impl/src/tile/message_sticker/message_sticker_scope.dart';
import 'package:feature_chat_impl/src/tile/model/tile_model.dart';
import 'package:feature_chat_impl/src/widget/chat_message/chat_message_factory.dart';
import 'package:flutter/material.dart';
import 'package:jugger/jugger.dart' as j;
import 'package:tile/tile.dart';

class MessageStickerTileFactoryDelegate
    implements ITileFactoryDelegate<MessageStickerTileModel> {
  MessageStickerTileFactoryDelegate({
    required ChatMessageFactory chatMessageFactory,
    required j.IProvider<MessageStickerBloc> blocProvider,
  })  : _chatMessageFactory = chatMessageFactory,
        _blocProvider = blocProvider;

  final ChatMessageFactory _chatMessageFactory;
  final j.IProvider<MessageStickerBloc> _blocProvider;

  @override
  Widget create(BuildContext context, MessageStickerTileModel model) {
    return MessageStickerScope(
      model: model,
      create: () => MessageStickerDependencies(
        blocProvider: _blocProvider,
        chatMessageFactory: _chatMessageFactory,
      ),
      child: const MessageSticker(),
    );
  }
}
