import 'package:feature_chat_impl/feature_chat_impl.dart';

import 'bloc/chat_event.dart';
import 'chat_screen.dart';

class MessageActionListener implements IMessageActionListener {
  MessageActionListener({required ChatBloc bloc}) : _bloc = bloc;

  final ChatBloc _bloc;

  @override
  void onSenderAvatarTap({required int senderId}) {
    _bloc.add(SenderTapEvent(senderId: senderId));
  }
}
