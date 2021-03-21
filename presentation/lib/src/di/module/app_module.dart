import 'package:core/core.dart';
import 'package:jugger/jugger.dart' as j;
import 'package:presentation/presentation.dart';
import 'package:presentation/src/navigation/navigation.dart';
import 'package:td_client/td_client.dart';

@j.module
abstract class AppModule {
  @j.singleton
  @j.provide
  static TdClient provideTdClient() {
    return TdClient();
  }

  @j.singleton
  @j.bind
  IChatRepository bindChatRepository(ChatRepositoryImpl impl);

  @j.singleton
  @j.provide
  static INavigationRouter provideRootNavigationRouter() {
    return RootNavigationRouter(navigatorKey);
  }
}
