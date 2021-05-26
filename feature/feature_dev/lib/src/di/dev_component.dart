import 'package:core_tdlib_api/core_tdlib_api.dart';
import 'package:feature_dev/feature_dev.dart';
import 'package:feature_dev/src/screen/root_page.dart';
import 'package:jugger/jugger.dart' as j;
import 'package:td_client/td_client.dart';

@j.Component(modules: <Type>[DevModule])
abstract class DevComponent {
  void injectRootState(RootPageState state);

  TdClient getTdClient();
}

@j.module
abstract class DevModule {
  @j.provide
  static TdClient provideTdClient(DevFeature devFeature) => devFeature.client;

  @j.provide
  @j.singleton
  static IConnectionStateProvider provideconnectionStateProvider(
          DevFeature devFeature) =>
      devFeature.connectionStateProvider;
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
