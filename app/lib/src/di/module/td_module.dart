import 'package:app/src/di/scope/application_scope.dart';
import 'package:core/core.dart';
import 'package:core_tdlib_api/core_tdlib_api.dart';
import 'package:core_tdlib_impl/core_tdlib_impl.dart';
import 'package:jugger/jugger.dart' as j;
import 'package:td_client/td_client.dart';

@j.module
abstract class TdModule {
  @applicationScope
  @j.provides
  static UpdatesProvider provideUpdatesProvider(TdClient client) =>
      UpdatesProvider(client: client);

  @applicationScope
  @j.binds
  IChatUpdatesProvider bindChatUpdatesProvider(UpdatesProvider impl);

  @applicationScope
  @j.binds
  IChatMessagesUpdatesProvider bindChatMessagesUpdatesProvider(
    UpdatesProvider impl,
  );

  @applicationScope
  @j.binds
  IChatFiltersUpdatesProvider bindChatFiltersUpdatesProvider(
    UpdatesProvider impl,
  );

  @applicationScope
  @j.binds
  @j.nonLazy
  IUserUpdatesProvider bindUserUpdatesProvider(UpdatesProvider impl);

  @applicationScope
  @j.provides
  static IConnectionStateProvider bindConnectionStateProvider(
    UpdatesProvider updatesProvider,
  ) =>
      ConnectionStateProviderImpl(
        updatesProvider: updatesProvider,
      );

  @applicationScope
  @j.provides
  static IAuthenticationStateProvider bindAuthenticationStateProvider(
    IAuthenticationStateUpdatesProvider authenticationStateUpdatesProvider,
  ) =>
      AuthenticationStateProviderImpl(
        authenticationStateUpdatesProvider: authenticationStateUpdatesProvider,
      );

  @applicationScope
  @j.binds
  IAuthenticationStateUpdatesProvider bindAuthenticationStateUpdatesProvider(
    UpdatesProvider impl,
  );

  @applicationScope
  @j.binds
  IFileUpdatesProvider bindFileUpdatesProvider(UpdatesProvider impl);

  @applicationScope
  @j.binds
  IEventsProvider bindEventsProvider(UpdatesProvider impl);

  @applicationScope
  @j.binds
  ISuperGroupUpdatesProvider bindSuperGroupUpdatesProvider(
    UpdatesProvider impl,
  );

  @applicationScope
  @j.binds
  IBasicGroupUpdatesProvider bindBasicGroupUpdatesProvider(
    UpdatesProvider impl,
  );

  @applicationScope
  @j.provides
  static ITdFunctionExecutor provideTdFunctionExecutor(TdClient client) =>
      TdFunctionExecutor(
        client: client,
      );

  @applicationScope
  @j.provides
  static MyChatProvider provideMyChatProvider(
    ITdFunctionExecutor functionExecutor,
    OptionsManager optionsManager,
  ) =>
      MyChatProvider(
        functionExecutor: functionExecutor,
        optionsManager: optionsManager,
      );
}
