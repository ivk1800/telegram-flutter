import 'package:feature_chat_impl/src/widget/chat_message/chat_message_factory.dart';
import 'package:jugger/jugger.dart' as j;

import 'message_sticker_bloc.dart';

class MessageStickerDependencies {
  const MessageStickerDependencies({
    required this.blocProvider,
    required this.chatMessageFactory,
  });

  final j.IProvider<MessageStickerBloc> blocProvider;
  final ChatMessageFactory chatMessageFactory;
}
