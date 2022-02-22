import 'package:feature_new_contact_impl/src/screen/new_contact/new_contact_router.dart';
import 'package:jugger/jugger.dart' as j;
import 'package:core_arch/core_arch.dart';

class NewContactViewModel extends BaseViewModel {
  @j.inject
  NewContactViewModel({
    required INewContactRouter router,
  }) : _router = router;

  final INewContactRouter _router;
}
