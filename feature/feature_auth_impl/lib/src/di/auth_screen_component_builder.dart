import 'package:feature_auth_impl/src/auth_feature_dependencies.dart';
import 'package:jugger/jugger.dart' as j;

import 'auth_screen_component.dart';

@j.componentBuilder
abstract class IAuthScreenComponentBuilder {
  IAuthScreenComponentBuilder dependencies(
    AuthFeatureDependencies dependencies,
  );

  IAuthScreenComponent build();
}
