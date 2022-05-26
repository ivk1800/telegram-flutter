import 'profile_type.dart';

abstract class IProfileRouter {
  void toChatProfile({required int chatId, required ProfileType type});
}
