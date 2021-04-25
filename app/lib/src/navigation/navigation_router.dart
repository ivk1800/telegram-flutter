abstract class INavigationRouter {
  void back();

  void toRootSettingsScreen();

  void toSessionsScreen();

  void toChat(int chatId);

  void toLogin();

  void toRoot();

  void toFolders();
}
