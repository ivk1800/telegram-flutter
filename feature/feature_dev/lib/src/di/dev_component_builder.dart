import 'package:feature_dev/feature_dev.dart';
import 'package:jugger/jugger.dart' as j;

import 'dev_component.dart';

@j.componentBuilder
abstract class IDevComponentBuilder {
  IDevComponentBuilder devDependencies(DevDependencies dependencies);

  IDevComponent build();
}
