import 'chat_administration_router.dart';

abstract class IChatAdministrationRouterFactory {
  IChatAdministrationRouter create(int chatId);
}
