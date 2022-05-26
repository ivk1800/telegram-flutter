library feature_new_contact_impl;

import 'package:feature_new_contact_api/feature_new_contact_api.dart';

import 'new_contact_feature_dependencies.dart';
import 'screen/new_contact/new_contact_screen_factory.dart';

class NewContactFeature implements INewContactFeatureApi {
  NewContactFeature({
    required NewContactFeatureDependencies dependencies,
  }) : _dependencies = dependencies;

  final NewContactFeatureDependencies _dependencies;
  late final NewContactScreenFactory _newContactScreenFactory =
      NewContactScreenFactory(dependencies: _dependencies);

  @override
  INewContactScreenFactory get newContactScreenFactory =>
      _newContactScreenFactory;
}
