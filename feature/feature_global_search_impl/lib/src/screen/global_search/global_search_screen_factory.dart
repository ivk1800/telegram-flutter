import 'package:feature_global_search_api/feature_global_search_api.dart';
import 'package:feature_global_search_impl/feature_global_search_impl.dart';
import 'package:feature_global_search_impl/src/screen/global_search/global_search_page.dart';
import 'package:flutter/widgets.dart';

import '../di/global_search_screen_component.jugger.dart';
import 'global_search_screen_scope.dart';

class GlobalSearchScreenFactory implements IGlobalSearchScreenFactory {
  GlobalSearchScreenFactory({
    required GlobalSearchFeatureDependencies dependencies,
  }) : _dependencies = dependencies;

  final GlobalSearchFeatureDependencies _dependencies;

  @override
  Widget create(GlobalSearchScreenController controller) {
    return GlobalSearchScreenScope(
      child: GlobalSearchPage(controller: controller),
      create: () => JuggerGlobalSearchScreenComponentBuilder()
          .dependencies(_dependencies)
          .build(),
    );
  }
}
