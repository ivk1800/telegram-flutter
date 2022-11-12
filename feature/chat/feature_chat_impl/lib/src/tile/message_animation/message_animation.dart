import 'package:core_arch_flutter/core_arch_flutter.dart';
import 'package:coreui/coreui.dart';
import 'package:feature_chat_impl/src/tile/bloc/media_mixin.dart';
import 'package:feature_chat_impl/src/tile/message_animation/message_animation_scope.dart';
import 'package:feature_chat_impl/src/tile/message_animation/message_animation_tile_model.dart';
import 'package:feature_chat_impl/src/widget/chat_context.dart';
import 'package:feature_chat_impl/src/widget/chat_message/chat_message.dart';
import 'package:feature_chat_impl/src/widget/media_widget.dart';
import 'package:feature_chat_impl/src/widget/message_composite_text.dart';
import 'package:flutter/material.dart';
import 'package:shared_models/shared_models.dart' as shm;

import 'message_animation_bloc.dart';

class MessageAnimation extends StatelessWidget {
  const MessageAnimation({super.key});

  @override
  Widget build(BuildContext context) {
    final MessageAnimationBloc bloc = MessageAnimationScope.getBloc(context);

    final MessageAnimationTileModel model = bloc.model;

    final ChatMessageFactory chatMessageFactory =
        MessageAnimationScope.getChatMessageFactory(context);
    final ReplyInfoFactory replyInfoFactory =
        MessageAnimationScope.getReplyInfoFactory(context);
    final ShortInfoFactory shortInfoFactory =
        MessageAnimationScope.getShortInfoFactory(context);

    final ChatContextData chatContextData = ChatContext.of(context);

    return chatMessageFactory.createConversationMessage(
      context: context,
      isOutgoing: model.isOutgoing,
      senderTitle: null,
      reply: replyInfoFactory.createFromMessageModel(context, model),
      blocks: <Widget>[
        MediaWrapper(
          type: MediaType.animation,
          child: StreamListener<MediaState>(
            stream: bloc.mediaState,
            builder: (BuildContext context, MediaState data) {
              return _MediaBody(state: data);
            },
          ),
          width: model.width,
          height: model.height,
        ),
        if (model.caption != null)
          MessageCaption(
            padding: EdgeInsets.only(
              left: chatContextData.horizontalPadding,
              right: chatContextData.horizontalPadding,
              top: chatContextData.verticalPadding,
            ),
            text: model.caption!,
            shortInfo: shortInfoFactory.create(
              context: context,
              additionalInfo: model.additionalInfo,
              isOutgoing: model.isOutgoing,
              padding: EdgeInsets.only(bottom: chatContextData.verticalPadding),
            ),
          ),
      ],
    );
  }
}

class _MediaBody extends StatelessWidget {
  const _MediaBody({required this.state});

  final MediaState state;

  @override
  Widget build(BuildContext context) {
    final MessageAnimationBloc bloc = MessageAnimationScope.getBloc(context);
    final MessageAnimationTileModel model = bloc.model;
    final shm.Minithumbnail? minithumbnail = model.minithumbnail;

    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 200),
      child: state.map(
        loading: (_) {
          return Container(
            constraints: const BoxConstraints.expand(),
            color: Colors.black,
            child: minithumbnail != null
                ? Minithumbnail(minithumbnail: minithumbnail)
                : null,
          );
        },
        loaded: (MediaStateLoaded loaded) {
          return SizedBox.expand(child: Image.file(loaded.file));
        },
      ),
    );
  }
}
