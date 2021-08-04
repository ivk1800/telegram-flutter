import 'package:feature_country_api/feature_country_api.dart';

typedef Callback = void Function(Country country);

class ChooseCountryArgs {
  ChooseCountryArgs({required this.callback});

  final void Function(Country country) callback;
}
