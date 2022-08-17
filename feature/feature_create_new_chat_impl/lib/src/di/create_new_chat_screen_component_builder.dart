import 'package:jugger/jugger.dart' as j;

import 'create_new_chat_component.dart';
import 'create_new_chat_screen_component.dart';

@j.componentBuilder
abstract class CreateNewChatScreenComponentBuilder {
  CreateNewChatScreenComponentBuilder createNewChatComponent(
    ICreateNewChatComponent component,
  );

  ICreateNewChatScreenComponent build();
}
