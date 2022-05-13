import 'package:flutter/widgets.dart';
import 'package:showcase/src/showcase_page.dart';

import 'di/showcase_component.dart';
import 'showcase/showcase_scope.dart';

class ShowcaseScreenFactory {
  ShowcaseScreenFactory({
    required IShowcaseComponent component,
  }) : _component = component;

  final IShowcaseComponent _component;

  Widget create() {
    return ShowcaseScope(
      child: const ShowcasePage(),
      create: () => _component,
    );
  }
}
