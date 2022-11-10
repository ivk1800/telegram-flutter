import 'package:block_interaction_api/block_interaction_api.dart';
import 'package:flutter/widgets.dart';
import 'package:jugger/jugger.dart' as j;
import 'package:localization_api/localization_api.dart';
import 'package:showcase/showcase.dart';
import 'package:showcase/src/showcase/auth_showcase_factory.dart';
import 'package:showcase/src/showcase/avatar/avatar_showcase_factory.dart';
import 'package:showcase/src/showcase/change_username_showcase_factory.dart';
import 'package:showcase/src/showcase/chat_forum_screen_showcase_factory.dart';
import 'package:showcase/src/showcase/create_new_channel_showcase_factory.dart';
import 'package:showcase/src/showcase/custom_emoji/custom_emoji_showcase_factory.dart';
import 'package:showcase/src/showcase/main_screen_showcase_factory.dart';
import 'package:showcase/src/showcase/message/message_showcase_factory.dart';
import 'package:showcase/src/showcase/message_wrap/message_wrap_showcase_factory.dart';
import 'package:showcase/src/showcase/new_contact_showcase_factory.dart';
import 'package:showcase/src/showcase/widget/showcase_block_interaction_manager.dart';
import 'package:tg_logger_api/tg_logger_api.dart';
import 'package:tg_logger_impl/tg_logger_impl.dart';

import 'showcase_component_builder.dart';

@j.Component(
  modules: <Type>[ShowcaseModule],
  builder: IShowcaseComponentBuilder,
)
@j.singleton
abstract class IShowcaseComponent {
  IStringsProvider getStringsProvider();

  ChangeUsernameShowcaseFactory getChangeUsernameShowcaseFactory();

  NewContactShowcaseFactory getNewContactShowcaseFactory();

  CreateNewChannelShowcaseFactory getCreateNewChannelShowcaseFactory();

  AuthShowcaseFactory getAuthShowcaseFactory();

  AvatarShowcaseFactory getAvatarShowcaseFactory();

  ShowcaseBlockInteractionManager getShowcaseBlockInteractionManager();

  GlobalKey<NavigatorState> getNavigatorKey();

  MessageShowcaseFactory getMessageShowcaseFactory();

  MainScreenShowcaseFactory getMainScreenShowcaseFactory();

  ChatForumScreenShowcaseFactory getChatForumScreenShowcaseFactory();

  CustomEmojiShowcaseFactory getCustomEmojiShowcaseFactory();

  MessageWrapShowcaseFactory getMessageWrapShowcaseFactory();
}

@j.module
abstract class ShowcaseModule {
  @j.provides
  @j.singleton
  static IStringsProvider provideStringsProvider(
    ShowcaseDependencies dependencies,
  ) =>
      dependencies.stringsProvider;

  @j.provides
  @j.singleton
  static MessageShowcaseFactory provideMessageShowcaseFactory(
    ShowcaseDependencies dependencies,
  ) =>
      MessageShowcaseFactory(
        stringsProvider: dependencies.stringsProvider,
      );

  @j.binds
  @j.singleton
  IBlockInteractionManager bindBlockInteractionManager(
    ShowcaseBlockInteractionManager impl,
  );

  @j.provides
  @j.singleton
  static GlobalKey<NavigatorState> provideNavigationKey(
    ShowcaseDependencies dependencies,
  ) =>
      dependencies.dialogNavigatorKey;

  @j.provides
  @j.singleton
  static ILogger provideLogger() => TgLoggerImpl();
}
