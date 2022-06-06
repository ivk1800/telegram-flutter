import 'package:feature_chat_impl/feature_chat_impl.dart';
import 'package:feature_chat_impl/src/tile/message_animation/message_animation.dart';
import 'package:feature_chat_impl/src/tile/message_animation/message_animation_bloc.dart';
import 'package:feature_chat_impl/src/widget/widget.dart';
import 'package:flutter/material.dart';
import 'package:jugger/jugger.dart' as j;
import 'package:tile/tile.dart';

import 'message_animation_dependencies.dart';
import 'message_animation_scope.dart';

class MessageAnimationTileFactoryDelegate
    implements ITileFactoryDelegate<MessageAnimationTileModel> {
  MessageAnimationTileFactoryDelegate({
    required ChatMessageFactory chatMessageFactory,
    required ShortInfoFactory shortInfoFactory,
    required ReplyInfoFactory replyInfoFactory,
    required j.IProvider<MessageAnimationBloc> blocProvider,
  })  : _chatMessageFactory = chatMessageFactory,
        _shortInfoFactory = shortInfoFactory,
        _blocProvider = blocProvider,
        _replyInfoFactory = replyInfoFactory;

  final ChatMessageFactory _chatMessageFactory;
  final ReplyInfoFactory _replyInfoFactory;
  final ShortInfoFactory _shortInfoFactory;
  final j.IProvider<MessageAnimationBloc> _blocProvider;

  @override
  Widget create(BuildContext context, MessageAnimationTileModel model) {
    return MessageAnimationScope(
      model: model,
      create: () => MessageAnimationDependencies(
        bloc: _blocProvider.get(),
        chatMessageFactory: _chatMessageFactory,
        replyInfoFactory: _replyInfoFactory,
        shortInfoFactory: _shortInfoFactory,
      ),
      child: const MessageAnimation(),
    );
  }
}
