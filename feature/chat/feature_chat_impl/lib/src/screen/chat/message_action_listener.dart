import 'package:feature_chat_impl/feature_chat_impl.dart';

import 'chat_screen.dart';

class MessageActionListener implements IMessageActionListener {
  MessageActionListener({
    required ChatMessagesViewModel viewModel,
  }) : _viewModel = viewModel;

  final ChatMessagesViewModel _viewModel;

  @override
  void onSenderAvatarTap({required int senderId, required SenderType type}) =>
      _viewModel.onSenderTap(senderId, type);
}
