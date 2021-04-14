import 'package:core/core.dart';
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
  IConnectionStateUpdatesProvider bindConnectionStateUpdatesProvider(
      UpdatesProvider impl);
}
