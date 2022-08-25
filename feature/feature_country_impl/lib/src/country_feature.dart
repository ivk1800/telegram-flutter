import 'package:feature_country_api/feature_country_api.dart';
import 'package:feature_country_impl/src/repository/country_repository.dart';

import 'country_feature_dependencies.dart';
import 'screen/factory/choose_country_screen_factory.dart';

class CountryFeature implements ICountryFeatureApi {
  CountryFeature({required CountryFeatureDependencies dependencies})
      : _dependencies = dependencies;

  final CountryFeatureDependencies _dependencies;

  @override
  late final IChooseCountryScreenFactory chooseCountryScreenFactory =
      ChooseCountryScreenFactory(dependencies: _dependencies);

  @override
  late final ICountryRepository countryRepository = const CountryRepository();
}
