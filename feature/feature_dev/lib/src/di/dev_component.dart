import 'package:core_tdlib_api/core_tdlib_api.dart';
import 'package:coreui/coreui.dart' as tg;
import 'package:feature_dev/feature_dev.dart';
import 'package:jugger/jugger.dart' as j;
import 'package:localization_api/localization_api.dart';
import 'package:showcase/showcase.dart';
import 'package:td_client/td_client.dart';

@j.Component(
  modules: <Type>[DevModule],
)
abstract class IDevComponent {
  TdClient getTdClient();

  tg.ConnectionStateWidgetFactory getConnectionStateWidgetFactory();

  ShowcaseFeature getShowcaseFeature();
}

@j.module
abstract class DevModule {
  @j.provides
  static TdClient provideTdClient(DevFeature devFeature) => devFeature.client;

  @j.provides
  @j.singleton
  static IConnectionStateProvider provideConnectionStateProvider(
    DevFeature devFeature,
  ) =>
      devFeature.connectionStateProvider;

  @j.provides
  @j.singleton
  static ShowcaseFeature provideShowcaseFeature(
    IStringsProvider stringsProvider,
  ) =>
      ShowcaseFeature(
          dependencies: ShowcaseDependencies(
        stringsProvider: stringsProvider,
      ));

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
  IDevComponentBuilder devFeature(DevFeature devFeature);

  IDevComponentBuilder stringsProvider(IStringsProvider stringsProvider);

  IDevComponent build();
}

// extension FoldersSetupComponentExt on RootPage {
//   // Widget wrap(IDevFeatureDependencies dependencies) =>
//   //     ComponentHolder<MainPage, MainPageState>(
//   //       componentFactory: (MainPageState state) =>
//   //           JuggerDevComponentBuilder()
//   //               .dependencies(dependencies)
//   //               .screenState(state)
//   //               .build(),
//   //       child: this,
//   //     );
// }
