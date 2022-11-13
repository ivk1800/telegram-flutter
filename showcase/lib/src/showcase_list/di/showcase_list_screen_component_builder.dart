import 'package:jugger/jugger.dart' as j;
import 'package:showcase/src/showcase_list/showcase_list_args.dart';

import 'showcase_list_screen_component.dart';

@j.componentBuilder
abstract class IShowcaseListScreenComponentBuilder {
  IShowcaseListScreenComponentBuilder setArgs(ShowcaseListArgs value);

  IShowcaseListScreenComponent build();
}
