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
      UpdatesProvider impl);

  @j.singleton
  @j.bind
  IConnectionStateProvider bindConnectionStateProvider(
      ConnectionStateProviderImpl impl);

  @j.singleton
  @j.bind
  IAuthenticationStateUpdatesProvider bindAuthenticationStateUpdatesProvider(
      UpdatesProvider impl);
}
