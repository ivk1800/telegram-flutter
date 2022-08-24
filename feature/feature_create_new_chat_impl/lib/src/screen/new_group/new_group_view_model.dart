import 'package:core_arch/core_arch.dart';
import 'package:feature_create_new_chat_impl/src/di/scope/screen_scope.dart';
import 'package:jugger/jugger.dart' as j;

@screenScope
@j.disposable
class NewGroupViewModel extends BaseViewModel {
  @j.inject
  NewGroupViewModel();
}
