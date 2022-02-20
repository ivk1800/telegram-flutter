import 'package:feature_chat_impl/feature_chat_impl.dart';

import 'chat_screen.dart';

class MessageActionListener implements IMessageActionListener {
  MessageActionListener({required ChatViewModel bloc}) : _viewModel = bloc;

  final ChatViewModel _viewModel;

  @override
  void onSenderAvatarTap({required int senderId, required SenderType type}) =>
      _viewModel.onSenderTap(senderId, type);
}
