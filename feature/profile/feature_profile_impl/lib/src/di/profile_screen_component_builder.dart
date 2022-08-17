import 'package:feature_profile_impl/src/profile_feature_dependencies.dart';
import 'package:feature_profile_impl/src/screen/profile/profile_args.dart';
import 'package:jugger/jugger.dart' as j;

import 'profile_screen_component.dart';

@j.componentBuilder
abstract class IProfileScreenComponentBuilder {
  IProfileScreenComponentBuilder dependencies(
    ProfileFeatureDependencies dependencies,
  );

  IProfileScreenComponentBuilder chatArgs(ProfileArgs args);

  IProfileScreenComponent build();
}
