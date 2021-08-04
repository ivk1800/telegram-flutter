library feature_add_contact_api;

import 'package:flutter/widgets.dart';

abstract class ICountryFeatureApi {
  IChooseCountryScreenFactory get chooseCountryScreenFactory;
}

abstract class IChooseCountryScreenFactory {
  Widget create(BuildContext context, void Function(Country country) callback);
}

class Country {
  Country({
    required this.name,
    required this.code,
    required this.phoneFormat,
  });

  final String name;
  final int code;

  final String? phoneFormat;
}
