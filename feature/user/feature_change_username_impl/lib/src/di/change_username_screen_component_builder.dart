import 'package:feature_change_username_impl/src/change_username_feature_dependencies.dart';
import 'package:jugger/jugger.dart' as j;

import 'change_username_screen_component.dart';

@j.componentBuilder
abstract class IChangeUsernameScreenComponentBuilder {
  IChangeUsernameScreenComponentBuilder dependencies(
    ChangeUsernameFeatureDependencies dependencies,
  );

  IChangeUsernameScreenComponent build();
}
