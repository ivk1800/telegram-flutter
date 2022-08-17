import 'package:feature_chat_impl/src/chat_feature_dependencies.dart';
import 'package:feature_chat_impl/src/screen/chat/chat_args.dart';
import 'package:jugger/jugger.dart' as j;

import 'chat_screen_component.dart';

@j.componentBuilder
abstract class IChatsScreenComponentBuilder {
  IChatsScreenComponentBuilder dependencies(
    ChatFeatureDependencies dependencies,
  );

  IChatsScreenComponentBuilder chatArgs(ChatArgs args);

  IChatScreenComponent build();
}
