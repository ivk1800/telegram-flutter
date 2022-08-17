import 'package:jugger/jugger.dart' as j;

import 'create_new_channel_screen_component.dart';
import 'create_new_chat_component.dart';

@j.componentBuilder
abstract class ICreateNewChannelScreenComponentBuilder {
  ICreateNewChannelScreenComponentBuilder createNewChatComponent(
    ICreateNewChatComponent component,
  );

  ICreateNewChannelScreenComponent build();
}
