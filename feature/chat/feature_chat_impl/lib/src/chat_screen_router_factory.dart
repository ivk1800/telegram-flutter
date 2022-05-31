import 'chat_screen_router.dart';

abstract class IChatScreenRouterFactory {
  IChatScreenRouter create(int chatId);
}
