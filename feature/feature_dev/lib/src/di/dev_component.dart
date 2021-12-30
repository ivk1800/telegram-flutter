import 'package:core_tdlib_api/core_tdlib_api.dart';
import 'package:coreui/coreui.dart';
import 'package:feature_dev/feature_dev.dart';
import 'package:feature_dev/src/screen/events_list_page.dart';
import 'package:feature_dev/src/screen/root_page.dart';
import 'package:jugger/jugger.dart' as j;
import 'package:td_client/td_client.dart';

@j.Component(modules: <Type>[DevModule])
abstract class DevComponent {
  void injectRootState(RootPageState state);

  void injectEventsListState(EventsListPageState state);

  TdClient getTdClient();
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

  @j.singleton
  @j.provides
  static ConnectionStateWidgetFactory provideConnectionStateWidgetFactory(
    IConnectionStateProvider connectionStateProvider,
  ) =>
      ConnectionStateWidgetFactory(
        connectionStateProvider: connectionStateProvider,
      );
}

@j.componentBuilder
abstract class DevComponentBuilder {
  DevComponentBuilder devFeature(DevFeature devFeature);

  DevComponent build();
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
