import 'package:core_tdlib_api/core_tdlib_api.dart';
import 'package:core_tdlib_impl/core_tdlib_impl.dart';
import 'package:jugger/jugger.dart' as j;
import 'package:td_client/td_client.dart';

@j.module
abstract class TdModule {
  @j.singleton
  @j.provides
  static UpdatesProvider provideUpdatesProvider(TdClient client) =>
      UpdatesProvider(client: client);

  @j.singleton
  @j.binds
  IChatUpdatesProvider bindChatUpdatesProvider(UpdatesProvider impl);

  @j.singleton
  @j.binds
  IChatFiltersUpdatesProvider bindChatFiltersUpdatesProvider(
    UpdatesProvider impl,
  );

  @j.singleton
  @j.provides
  static IConnectionStateProvider bindConnectionStateProvider(
    UpdatesProvider updatesProvider,
  ) =>
      ConnectionStateProviderImpl(
        updatesProvider: updatesProvider,
      );

  @j.singleton
  @j.binds
  IAuthenticationStateUpdatesProvider bindAuthenticationStateUpdatesProvider(
    UpdatesProvider impl,
  );

  @j.singleton
  @j.binds
  IFileUpdatesProvider bindFileUpdatesProvider(UpdatesProvider impl);

  @j.singleton
  @j.binds
  ISuperGroupUpdatesProvider bindSuperGroupUpdatesProvider(
    UpdatesProvider impl,
  );

  @j.singleton
  @j.binds
  IBasicGroupUpdatesProvider bindBasicGroupUpdatesProvider(
    UpdatesProvider impl,
  );

  @j.singleton
  @j.provides
  static ITdFunctionExecutor provideTdFunctionExecutor(TdClient client) =>
      TdFunctionExecutor(
        client: client,
      );
}
