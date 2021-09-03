import 'package:feature_global_search_api/feature_global_search_api.dart';
import 'package:feature_global_search_impl/feature_global_search_impl.dart';
import 'package:feature_global_search_impl/src/screen/global_search_page.dart';
import 'package:flutter/widgets.dart';

class GlobalSearchWidgetFactory implements IGlobalSearchWidgetFactory {
  GlobalSearchWidgetFactory({required this.dependencies});

  final GlobalSearchFeatureDependencies dependencies;

  @override
  Widget create() => const GlobalSearchPage();
}
