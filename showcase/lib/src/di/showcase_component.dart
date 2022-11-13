import 'package:block_interaction_api/block_interaction_api.dart';
import 'package:flutter/widgets.dart';
import 'package:jugger/jugger.dart' as j;
import 'package:localization_api/localization_api.dart';
import 'package:showcase/showcase.dart';
import 'package:showcase/src/showcase/message/message_showcase_factory.dart';
import 'package:showcase/src/showcase/showcase_list_router_impl.dart';
import 'package:showcase/src/showcase/showcase_scope_delegate.dart';
import 'package:showcase/src/showcase/widget/showcase_block_interaction_manager.dart';
import 'package:showcase/src/showcase_list/di/showcase_list_screen_component.dart';
import 'package:showcase/src/showcase_list/di/showcase_list_screen_component_builder.dart';
import 'package:showcase/src/showcase_list/showcase_list_router.dart';
import 'package:showcase/src/showcase_page.dart';
import 'package:split_view/split_view.dart';
import 'package:tg_logger_api/tg_logger_api.dart';
import 'package:tg_logger_impl/tg_logger_impl.dart';

import 'showcase_component_builder.dart';

@j.Component(
  modules: <Type>[ShowcaseModule],
  builder: IShowcaseComponentBuilder,
)
@j.singleton
abstract class IShowcaseComponent implements IShowcaseScopeDelegate {
  IStringsProvider getStringsProvider();

  GlobalKey<NavigatorState> getNavigatorKey();

  @j.subcomponentFactory
  IShowcaseListScreenComponent createShowcaseListScreenComponent(
    IShowcaseListScreenComponentBuilder builder,
  );
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

  @j.binds
  @j.singleton
  IShowcaseListRouter bindShowcaseListRouter(ShowcaseListRouterImpl impl);

  @j.provides
  @j.singleton
  static GlobalKey<SplitViewState> provideNavigatorKey() =>
      ShowcasePage.splitViewNavigatorKey;
}
