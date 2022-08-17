import 'package:feature_new_contact_impl/src/new_contact_feature_dependencies.dart';
import 'package:feature_new_contact_impl/src/screen/new_contact/args.dart';
import 'package:jugger/jugger.dart' as j;

import 'new_contact_screen_component.dart';

@j.componentBuilder
abstract class INewContactScreenComponentBuilder {
  INewContactScreenComponentBuilder dependencies(
    NewContactFeatureDependencies dependencies,
  );

  INewContactScreenComponentBuilder args(Args args);

  INewContactScreenComponent build();
}
