import 'package:feature_chat_impl/src/widget/chat_message/chat_message_factory.dart';
import 'package:feature_chat_impl/src/widget/chat_message/reply_info_factory.dart';
import 'package:feature_chat_impl/src/widget/chat_message/short_info_factory.dart';

import 'message_animation_bloc.dart';

class MessageAnimationDependencies {
  const MessageAnimationDependencies({
    required this.bloc,
    required this.chatMessageFactory,
    required this.shortInfoFactory,
    required this.replyInfoFactory,
  });

  final MessageAnimationBloc bloc;
  final ChatMessageFactory chatMessageFactory;
  final ReplyInfoFactory replyInfoFactory;
  final ShortInfoFactory shortInfoFactory;
}
