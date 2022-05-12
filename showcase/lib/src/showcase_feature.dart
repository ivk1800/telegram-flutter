import 'package:flutter/material.dart';
import 'package:localization_api/localization_api.dart';
import 'package:showcase/src/showcase/showcase_scope.dart';

import 'di/showcase_component.dart';
import 'di/showcase_component.jugger.dart';
import 'showcase/widget/showcase_block_interaction_manager.dart';
import 'showcase_page.dart';

class ShowcaseFeature {
  ShowcaseFeature({
    required ShowcaseDependencies dependencies,
  }) : _dependencies = dependencies;

  final ShowcaseDependencies _dependencies;

  late final IShowcaseComponent _component =
      JuggerShowcaseComponentBuilder().dependencies(_dependencies).build();

  ShowcaseBlockInteractionManager get showcaseBlockInteractionManager =>
      _component.getShowcaseBlockInteractionManager();

  GlobalKey<NavigatorState> get navigationKey => _component.getNavigatorKey();

  Widget createScreen() {
    return ShowcaseScope(
      child: const ShowcasePage(),
      create: () => _component,
    );
  }
}

class ShowcaseDependencies {
  ShowcaseDependencies({
    required this.stringsProvider,
  });

  final IStringsProvider stringsProvider;
}
