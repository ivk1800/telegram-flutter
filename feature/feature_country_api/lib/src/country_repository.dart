import 'country.dart';

abstract class ICountryRepository {
  Future<List<Country>> getCountries();

  Future<Country?> findByCode({required int code});
}
