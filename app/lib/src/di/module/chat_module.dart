import 'package:app/src/di/scope/application_scope.dart';
import 'package:chat_kit/chat_kit.dart';
import 'package:core_tdlib_api/core_tdlib_api.dart';
import 'package:jugger/jugger.dart' as j;

@j.module
abstract class ChatModuleModule {
  @applicationScope
  @j.provides
  @j.nonLazy
  static ChatBackgroundManager provideChatBackgroundManager(
    IBackgroundRepository backgroundRepository,
    IAuthenticationStateProvider authenticationStateProvider,
    IAuthenticationStateUpdatesProvider authenticationStateUpdatesProvider,
  ) =>
      ChatBackgroundManager(
        activeBackgroundStorage: ActiveBackgroundStorage(),
        backgroundRepository: backgroundRepository,
        authenticationStateUpdatesProvider: authenticationStateUpdatesProvider,
        authenticationStateProvider: authenticationStateProvider,
      );
}
