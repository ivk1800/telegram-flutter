import 'package:feature_chat_forum_impl/src/chat_forum_feature_dependencies.dmg.dart';
import 'package:feature_chat_forum_impl/src/di/chat_forum_screen_module.dart';
import 'package:feature_chat_forum_impl/src/screen/chat_forum_screen_scope_delegate.dart';
import 'package:jugger/jugger.dart' as j;

import 'chat_forum_screen_component_builder.dart';

@j.Component(
  modules: <Type>[
    ChatForumFeatureDependenciesModule,
    ChatForumScreenModule,
  ],
  builder: IChatForumScreenComponentBuilder,
)
@j.singleton
abstract class IChatForumScreenComponent
    implements IChatForumScreenScopeDelegate {}
