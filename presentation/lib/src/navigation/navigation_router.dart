abstract class INavigationRouter {
  void back();

  void toRootSettingsScreen();

  void toSessionsScreen();

  void toChat(int chatId);
}
