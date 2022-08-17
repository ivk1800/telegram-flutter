import 'package:feature_chat_impl/src/di/chat_screen_component.dart';
import 'package:jugger/jugger.dart' as j;

import 'empty_chat_component.dart';

@j.componentBuilder
abstract class IEmptyChatComponentBuilder {
  IEmptyChatComponentBuilder setChatScreenComponent(
    IChatScreenComponent component,
  );

  IEmptyChatComponent build();
}
