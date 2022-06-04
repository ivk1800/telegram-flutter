import 'sender_type.dart';

abstract class IMessageActionListener {
  void onSenderAvatarTap({required int senderId, required SenderType type});
}
