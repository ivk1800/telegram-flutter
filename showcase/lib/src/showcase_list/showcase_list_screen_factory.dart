import 'package:flutter/widgets.dart';
import 'package:jugger/jugger.dart' as j;
import 'package:showcase/src/di/showcase_component.dart';
import 'package:showcase/src/di/showcase_component.jugger.dart';
import 'package:showcase/src/showcase_list/showcase_list_page.dart';
import 'package:tile/tile.dart';

import 'showcase_list_args.dart';
import 'showcase_list_scope_delegate.scope.dart';

class ShowcaseListScreenFactory {
  @j.inject
  ShowcaseListScreenFactory({
    required IShowcaseComponent component,
  }) : _component = component;

  final IShowcaseComponent _component;

  Widget create({
    required String title,
    required List<ITileModel> items,
  }) {
    return ShowcaseListScreenScope(
      child: const ShowcaseListPage(),
      create: () => _component.createShowcaseListScreenComponent(
        JuggerSubcomponent$ShowcaseListScreenComponentBuilder()
            .setArgs(ShowcaseListArgs(title: title, items: items)),
      ),
    );
  }
}
