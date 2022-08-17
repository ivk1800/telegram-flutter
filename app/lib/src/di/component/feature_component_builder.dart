import 'package:jugger/jugger.dart' as j;

import 'app_component.dart';
import 'feature_component.dart';

@j.componentBuilder
abstract class IFeatureComponentBuilder {
  IFeatureComponentBuilder appComponent(IAppComponent appComponent);

  IFeatureComponent build();
}
