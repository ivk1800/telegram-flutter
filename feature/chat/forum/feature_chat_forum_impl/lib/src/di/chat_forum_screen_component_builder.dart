import 'package:feature_chat_forum_impl/src/chat_forum_feature_dependencies.dart';
import 'package:jugger/jugger.dart' as j;

import 'chat_forum_screen_component.dart';

@j.componentBuilder
abstract class IChatForumScreenComponentBuilder {
  IChatForumScreenComponentBuilder dependencies(
    ChatForumFeatureDependencies dependencies,
  );

  IChatForumScreenComponent build();
}
