import 'package:core_arch_flutter/core_arch_flutter.dart';
import 'package:coreui/coreui.dart' as tg;
import 'package:feature_chat_impl/src/tile/message_sticker/message_sticker_bloc.dart';
import 'package:feature_chat_impl/src/tile/message_sticker/message_sticker_scope.dart';
import 'package:feature_chat_impl/src/widget/chat_message/chat_message.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'message_sticker_state.dart';

class MessageSticker extends StatelessWidget {
  const MessageSticker({super.key});

  @override
  Widget build(BuildContext context) {
    final MessageStickerBloc bloc = MessageStickerScope.getBloc(context);
    final ChatMessageFactory chatMessageFactory =
        MessageStickerScope.getChatMessageFactory(context);

    return chatMessageFactory.createFromBlocks(
      id: bloc.id,
      context: context,
      isOutgoing: bloc.isOutgoing,
      withBubble: false,
      blocks: <Widget>[
        SizedBox(
          width: 200,
          height: 200,
          child: StreamListener<MessageStickerState>(
            stream: bloc.state,
            builder: (BuildContext context, MessageStickerState state) {
              return GestureDetector(
                onTap: bloc.onStickerTap,
                child: _StickerBody(state: state),
              );
            },
          ),
        ),
      ],
    );
  }
}

class _StickerBody extends StatelessWidget {
  const _StickerBody({required this.state});

  final MessageStickerState state;

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 200),
      child: state.map(
        loading: (_) => Stack(
          alignment: Alignment.center,
          children: const <Widget>[
            // todo implement outline
            Placeholder(),
            Text(
              'loading',
              textAlign: TextAlign.center,
            )
          ],
        ),
        loadedStatic: (MessageStickerStateLoadedStatic loaded) {
          return Image.file(loaded.file);
        },
        loadedAnimated: (MessageStickerStateLoadedAnimated loaded) {
          return tg.Sticker(file: loaded.file);
        },
      ),
    );
  }
}
