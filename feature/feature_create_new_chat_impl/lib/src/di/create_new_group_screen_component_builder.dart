import 'package:jugger/jugger.dart' as j;

import 'create_new_chat_component.dart';
import 'create_new_group_screen_component.dart';

@j.componentBuilder
abstract class CreateNewGroupScreenComponentBuilder {
  CreateNewGroupScreenComponentBuilder createNewChatComponent(
    ICreateNewChatComponent component,
  );

  ICreateNewGroupScreenComponent build();
}
