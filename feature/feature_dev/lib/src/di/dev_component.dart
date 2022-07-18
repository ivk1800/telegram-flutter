import 'package:core_tdlib_api/core_tdlib_api.dart';
import 'package:coreui/coreui.dart' as tg;
import 'package:feature_dev/feature_dev.dart';
import 'package:feature_dev/src/events_repository.dart';
import 'package:feature_dev/src/screen/events_list/events_list_screen_factory.dart';
import 'package:jugger/jugger.dart' as j;
import 'package:showcase/showcase.dart';
import 'package:theme_manager_api/theme_manager_api.dart';

@j.Component(
  modules: <Type>[DevModule],
)
abstract class IDevComponent {
  IEventsProvider getEventsProvider();

  tg.ConnectionStateWidgetFactory getConnectionStateWidgetFactory();

  ShowcaseFeature getShowcaseFeature();

  IDevFeatureRouter getRouter();

  ShowcaseScreenFactory getShowcaseScreenFactory();

  ITdFunctionExecutor getTdFunctionExecutor();

  IThemeManager getThemeManager();

  EventsRepository getEventsRepository();

  EventsListScreenFactory getEventsListScreenFactory();
}

@j.module
abstract class DevModule {
  @j.provides
  static IEventsProvider provideEventsProvider(
    DevDependencies dependencies,
  ) =>
      dependencies.eventsProvider;

  @j.provides
  static IDevFeatureRouter provideDevFeatureRouter(
    DevDependencies dependencies,
  ) =>
      dependencies.router;

  @j.provides
  @j.singleton
  static EventsRepository provideEventsRepository(
    DevDependencies dependencies,
  ) =>
      EventsRepository(
        eventsProvider: dependencies.eventsProvider,
      )..init();

  @j.provides
  @j.singleton
  static EventsListScreenFactory provideEventsListScreenFactory(
    EventsRepository eventsRepository,
    DevDependencies dependencies,
  ) =>
      EventsListScreenFactory(
        eventsRepository: eventsRepository,
        connectionStateProvider: dependencies.connectionStateProvider,
      );

  @j.provides
  static ShowcaseScreenFactory provideShowcaseScreenFactory(
    ShowcaseFeature showcaseFeature,
  ) =>
      showcaseFeature.showcaseScreenFactory;

  @j.provides
  static IThemeManager provideThemeManager(
    DevDependencies dependencies,
  ) =>
      dependencies.themeManager;

  @j.provides
  static ITdFunctionExecutor provideTdFunctionExecutor(
    DevDependencies dependencies,
  ) =>
      dependencies.functionExecutor;

  @j.provides
  @j.singleton
  static IConnectionStateProvider provideConnectionStateProvider(
    DevDependencies dependencies,
  ) =>
      dependencies.connectionStateProvider;

  @j.provides
  @j.singleton
  static ShowcaseFeature provideShowcaseFeature(DevDependencies dependencies) =>
      ShowcaseFeature(
        dependencies: ShowcaseDependencies(
          stringsProvider: dependencies.stringsProvider,
          dialogNavigatorKey: dependencies.navigatorKey,
        ),
      );

  @j.singleton
  @j.provides
  static tg.ConnectionStateWidgetFactory provideConnectionStateWidgetFactory(
    IConnectionStateProvider connectionStateProvider,
  ) =>
      tg.ConnectionStateWidgetFactory(
        connectionStateProvider: connectionStateProvider,
      );
}

@j.componentBuilder
abstract class IDevComponentBuilder {
  IDevComponentBuilder devDependencies(DevDependencies dependencies);

  IDevComponent build();
}
