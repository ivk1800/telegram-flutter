import 'package:block_interaction_api/block_interaction_api.dart';
import 'package:flutter/widgets.dart';
import 'package:jugger/jugger.dart' as j;
import 'package:localization_api/localization_api.dart';
import 'package:showcase/showcase.dart';
import 'package:showcase/src/showcase/auth_showcase_factory.dart';
import 'package:showcase/src/showcase/change_username_showcase_factory.dart';
import 'package:showcase/src/showcase/create_new_channel_showcase_factory.dart';
import 'package:showcase/src/showcase/message/message_showcase_factory.dart';
import 'package:showcase/src/showcase/new_contact_showcase_factory.dart';
import 'package:showcase/src/showcase/widget/showcase_block_interaction_manager.dart';

@j.Component(
  modules: <Type>[ShowcaseModule],
)
abstract class IShowcaseComponent {
  IStringsProvider getStringsProvider();

  ChangeUsernameShowcaseFactory getChangeUsernameShowcaseFactory();

  NewContactShowcaseFactory getNewContactShowcaseFactory();

  CreateNewChannelShowcaseFactory getCreateNewChannelShowcaseFactory();

  AuthShowcaseFactory getAuthShowcaseFactory();

  ShowcaseBlockInteractionManager getShowcaseBlockInteractionManager();

  GlobalKey<NavigatorState> getNavigatorKey();

  MessageShowcaseFactory getMessageShowcaseFactory();
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
  static GlobalKey<NavigatorState> provideNavigationKey() =>
      GlobalKey<NavigatorState>();
}

@j.componentBuilder
abstract class IShowcaseComponentBuilder {
  IShowcaseComponentBuilder dependencies(
    ShowcaseDependencies dependencies,
  );

  IShowcaseComponent build();
}
