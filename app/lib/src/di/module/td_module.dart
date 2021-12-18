import 'package:core_tdlib_api/core_tdlib_api.dart';
import 'package:core_tdlib_impl/core_tdlib_impl.dart';
import 'package:jugger/jugger.dart' as j;
import 'package:td_client/td_client.dart';

abstract class TdModule {
  @j.singleton
  @j.provide
  static UpdatesProvider provideUpdatesProvider(TdClient client) =>
      UpdatesProvider(client: client);

  @j.singleton
  @j.bind
  IChatUpdatesProvider bindChatUpdatesProvider(UpdatesProvider impl);

  @j.singleton
  @j.bind
  IChatFiltersUpdatesProvider bindChatFiltersUpdatesProvider(
    UpdatesProvider impl,
  );

  @j.singleton
  @j.provide
  static IConnectionStateProvider bindConnectionStateProvider(
    UpdatesProvider updatesProvider,
  ) =>
      ConnectionStateProviderImpl(
        updatesProvider: updatesProvider,
      );

  @j.singleton
  @j.bind
  IAuthenticationStateUpdatesProvider bindAuthenticationStateUpdatesProvider(
      UpdatesProvider impl);

  @j.singleton
  @j.bind
  IFileUpdatesProvider bindFileUpdatesProvider(UpdatesProvider impl);

  @j.singleton
  @j.provide
  static ISuperGroupUpdatesProvider provideSuperGroupUpdatesProvider(
    UpdatesProvider impl,
  ) =>
      impl;

  @j.singleton
  @j.provide
  static ITdFunctionExecutor provideTdFunctionExecutor(TdClient client) =>
      TdFunctionExecutor(
        client: client,
      );
}
