import 'package:chat_actions_panel/src/chat_action_panel_dependencies.dart';
import 'package:jugger/jugger.dart' as j;

import 'chat_actions_panel_component.dart';

@j.componentBuilder
abstract class IChatActionsPanelComponentBuilder {
  IChatActionsPanelComponentBuilder dependencies(
    ChatActionPanelDependencies dependencies,
  );

  IChatActionsPanelComponent build();
}
