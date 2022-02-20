library profile_navigation_api;

abstract class IProfileRouter {
  void toChatProfile({required int chatId, required ProfileType type});
}

enum ProfileType {
  user,
  chat,
}
