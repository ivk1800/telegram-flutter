import 'choose_country_screen_factory.dart';
import 'country_repository.dart';

abstract class ICountryFeatureApi {
  IChooseCountryScreenFactory get chooseCountryScreenFactory;

  ICountryRepository get countryRepository;
}
