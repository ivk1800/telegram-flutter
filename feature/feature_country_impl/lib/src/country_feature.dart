import 'package:feature_country_api/feature_country_api.dart';
import 'package:feature_country_impl/src/repository/country_repository.dart';

import 'country_feature_dependencies.dart';
import 'screen/factory/choose_country_screen_factory.dart';

class CountryFeature implements ICountryFeatureApi {
  CountryFeature({required CountryFeatureDependencies dependencies})
      : _dependencies = dependencies;

  final CountryFeatureDependencies _dependencies;

  late final ChooseCountryScreenFactory _chooseCountryScreenFactory =
      ChooseCountryScreenFactory(
    dependencies: _dependencies,
  );
  late final CountryRepository _countryRepository = const CountryRepository();

  @override
  IChooseCountryScreenFactory get chooseCountryScreenFactory =>
      _chooseCountryScreenFactory;

  @override
  ICountryRepository get countryRepository => _countryRepository;
}
