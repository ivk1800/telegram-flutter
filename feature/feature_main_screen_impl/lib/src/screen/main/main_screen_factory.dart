import 'package:core_arch_flutter/core_arch_flutter.dart';
import 'package:coreui/coreui.dart' as tg;
import 'package:feature_chats_list_api/feature_chats_list_api.dart';
import 'package:feature_global_search_api/feature_global_search_api.dart';
import 'package:feature_main_screen_api/feature_main_screen_api.dart';
import 'package:feature_main_screen_impl/feature_main_screen_impl.dart';
import 'package:feature_main_screen_impl/src/di/main_screen_component.dart';
import 'package:feature_main_screen_impl/src/di/main_screen_component.jugger.dart';
import 'package:flutter/widgets.dart';
import 'package:localization_api/localization_api.dart';
import 'package:provider/provider.dart';
import 'package:provider_extensions/provider_extensions.dart';

import 'main_page.dart';
import 'main_view_model.dart';

class MainScreenFactory implements IMainScreenFactory {
  const MainScreenFactory({
    required MainScreenFeatureDependencies dependencies,
  }) : _dependencies = dependencies;

  final MainScreenFeatureDependencies _dependencies;

  @override
  Widget create() {
    return Scope<IMainScreenComponent>(
      create: () => JuggerMainScreenComponentBuilder()
          .dependencies(_dependencies)
          .build(),
      providers: (IMainScreenComponent component) {
        return <Provider<dynamic>>[
          ViewModelProvider<MainViewModel>(
            create: (BuildContext _) => component.getMainViewModel(),
          ),
          Provider<ILocalizationManager>(
            create: (BuildContext _) => component.getLocalizationManager(),
          ),
          Provider<IGlobalSearchScreenFactory>(
            create: (BuildContext _) =>
                component.getGlobalSearchScreenFactory(),
          ),
          Provider<IChatsListScreenFactory>(
            create: (BuildContext _) => component.getChatsListScreenFactory(),
          ),
          Provider<tg.ConnectionStateWidgetFactory>(
            create: (BuildContext _) =>
                component.getConnectionStateWidgetFactory(),
          ),
        ];
      },
      child: const MainPage(),
    );
  }
}
