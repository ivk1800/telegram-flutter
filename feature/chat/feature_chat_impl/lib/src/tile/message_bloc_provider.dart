import 'package:jugger/jugger.dart' as j;

import 'message_sticker/message_sticker_bloc.dart';

class MessageBlocProvider {
  @j.inject
  MessageBlocProvider({required this.messageStickerBlocProvider});

  final j.IProvider<MessageStickerBloc> messageStickerBlocProvider;
}
