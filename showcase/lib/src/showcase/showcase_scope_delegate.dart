import 'package:scope_generator_annotation/scope_generator_annotation.dart';
import 'package:showcase/src/showcase/image_widget/image_widget_showcase_factory.dart';

import 'auth_showcase_factory.dart';
import 'avatar/avatar_showcase_factory.dart';
import 'change_username_showcase_factory.dart';
import 'chat_forum_screen_showcase_factory.dart';
import 'circular_progress/circular_progress_widget_showcase_factory.dart';
import 'create_new_channel_showcase_factory.dart';
import 'custom_emoji/custom_emoji_showcase_factory.dart';
import 'main_screen_showcase_factory.dart';
import 'message/message_showcase_factory.dart';
import 'message_wrap/message_wrap_showcase_factory.dart';
import 'new_contact_showcase_factory.dart';
import 'widget/showcase_block_interaction_manager.dart';

@scope
abstract class IShowcaseScopeDelegate {
  ChangeUsernameShowcaseFactory getChangeUsernameShowcaseFactory();

  NewContactShowcaseFactory getNewContactShowcaseFactory();

  CreateNewChannelShowcaseFactory getCreateNewChannelShowcaseFactory();

  AuthShowcaseFactory getAuthShowcaseFactory();

  ShowcaseBlockInteractionManager getShowcaseBlockInteractionManager();

  MessageShowcaseFactory getMessageShowcaseFactory();

  MainScreenShowcaseFactory getMainScreenShowcaseFactory();

  AvatarShowcaseFactory getAvatarShowcaseFactory();

  ChatForumScreenShowcaseFactory getChatForumScreenShowcaseFactory();

  CustomEmojiShowcaseFactory getCustomEmojiShowcaseFactory();

  MessageWrapShowcaseFactory getMessageWrapShowcaseFactory();

  CircularProgressWidgetShowcaseFactory
      getCircularProgressWidgetShowcaseFactory();
}
