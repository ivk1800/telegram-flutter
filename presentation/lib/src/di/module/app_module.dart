import 'package:core/core.dart';
import 'package:jugger/jugger.dart' as j;
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
}
