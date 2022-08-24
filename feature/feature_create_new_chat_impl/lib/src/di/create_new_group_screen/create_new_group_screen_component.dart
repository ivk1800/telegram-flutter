import 'package:feature_create_new_chat_impl/src/di/scope/screen_scope.dart';
import 'package:feature_create_new_chat_impl/src/screen/new_group/new_group_screen_scope_delegate.dart';
import 'package:jugger/jugger.dart' as j;

@j.Subcomponent(
  modules: <Type>[CreateNewGroupScreenModule],
)
@screenScope
abstract class ICreateNewGroupScreenComponent
    implements INewGroupScreenScopeDelegate {}

@j.module
abstract class CreateNewGroupScreenModule {}
