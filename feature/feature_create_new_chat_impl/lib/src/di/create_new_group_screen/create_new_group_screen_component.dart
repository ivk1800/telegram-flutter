import 'package:feature_create_new_chat_impl/src/di/scope/screen_scope.dart';
import 'package:feature_create_new_chat_impl/src/screen/new_group/new_group.dart';
import 'package:jugger/jugger.dart' as j;
import 'package:localization_api/localization_api.dart';

@j.Subcomponent(
  modules: <Type>[CreateNewGroupScreenModule],
)
@screenScope
abstract class ICreateNewGroupScreenComponent {
  NewGroupViewModel getNewGroupViewModel();

  IStringsProvider getStringsProvider();
}

@j.module
abstract class CreateNewGroupScreenModule {}
