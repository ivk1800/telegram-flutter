import 'package:dialog_api/dialog_api.dart';
import 'package:feature_country_api/feature_country_api.dart';

abstract class IDevFeatureRouter implements IDialogRouter {
  void toEventsList();

  void toCreateNewChat();

  void toWallPapers();

  // todo use router from navigation module of country
  void toChooseCountry(void Function(Country country) callback);
}
