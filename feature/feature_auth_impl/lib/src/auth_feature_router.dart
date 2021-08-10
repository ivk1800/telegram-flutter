import 'package:dialog_api/dialog_api.dart';
import 'package:feature_country_api/feature_country_api.dart';

abstract class IAuthFeatureRouter implements IDialogRouter {
  void toChooseCountry(void Function(Country country) callback);
}
