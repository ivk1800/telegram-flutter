import 'package:feature_global_search_api/feature_global_search_api.dart';
import 'package:feature_global_search_impl/feature_global_search_impl.dart';
import 'package:feature_global_search_impl/src/screen/global_search/global_search_page.dart';
import 'package:flutter/widgets.dart';
import 'package:localization_api/localization_api.dart';
import 'package:provider/provider.dart';
import 'package:provider_extensions/provider_extensions.dart';
import 'package:tile/tile.dart';

import 'cubit/global_search_cubit.dart';
import 'di/global_search_screen_component.dart';
import 'di/global_search_screen_component.jugger.dart';

class GlobalSearchScreenFactory implements IGlobalSearchScreenFactory {
  GlobalSearchScreenFactory({
    required GlobalSearchFeatureDependencies dependencies,
  }) : _dependencies = dependencies;

  final GlobalSearchFeatureDependencies _dependencies;

  @override
  Widget create(GlobalSearchScreenController controller) {
    return Scope<GlobalSearchScreenComponent>(
      create: () => JuggerGlobalSearchScreenComponentBuilder()
          .dependencies(_dependencies)
          .build(),
      providers: (GlobalSearchScreenComponent component) {
        return <Provider<dynamic>>[
          Provider<TileFactory>(
            create: (BuildContext context) => component.getTileFactory(),
          ),
          Provider<ILocalizationManager>(
            create: (BuildContext context) =>
                component.getLocalizationManager(),
          ),
          Provider<GlobalSearchCubit>(
            create: (BuildContext context) => component.getGlobalSearchCubit(),
          ),
        ];
      },
      child: GlobalSearchPage(
        controller: controller,
      ),
    );
  }
}
