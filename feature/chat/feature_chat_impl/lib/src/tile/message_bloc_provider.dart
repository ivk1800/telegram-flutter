import 'package:jugger/jugger.dart' as j;

import 'message_animation/message_animation_bloc.dart';
import 'message_sticker/message_sticker_bloc.dart';

class MessageBlocProvider {
  @j.inject
  MessageBlocProvider({
    required this.messageStickerBlocProvider,
    required this.messageAnimationBlocProvider,
  });

  final j.IProvider<MessageStickerBloc> messageStickerBlocProvider;
  final j.IProvider<MessageAnimationBloc> messageAnimationBlocProvider;
}
