import 'package:flutter/widgets.dart';

import 'country.dart';

abstract class IChooseCountryScreenFactory {
  Widget create(void Function(Country country) callback);
}
