import 'package:feature_global_search_api/feature_global_search_api.dart';
import 'package:flutter/widgets.dart';

class FakeGlobalSearchScreenFactory implements IGlobalSearchScreenFactory {
  const FakeGlobalSearchScreenFactory();

  @override
  Widget create(GlobalSearchScreenController controller) {
    return const Center(child: Text('FakeGlobalSearchScreen'));
  }
}
