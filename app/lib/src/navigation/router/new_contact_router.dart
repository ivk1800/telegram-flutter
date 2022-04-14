import 'package:app/src/navigation/common_screen_router_impl.dart';
import 'package:app/src/navigation/navigation.dart';
import 'package:app/src/navigation/navigation_router.dart';
import 'package:dialog_api/dialog_api.dart' as d;
import 'package:feature_new_contact_impl/feature_new_contact_impl.dart';
import 'package:jugger/jugger.dart' as j;

class NewContactRouterImpl implements INewContactRouter {
  @j.inject
  NewContactRouterImpl({
    required CommonScreenRouterImpl commonScreenRouter,
    required ISplitNavigationDelegate navigationDelegate,
    required KeyGenerator keyGenerator,
  })  : _commonScreenRouter = commonScreenRouter,
        _keyGenerator = keyGenerator,
        _navigationDelegate = navigationDelegate;

  final CommonScreenRouterImpl _commonScreenRouter;
  final KeyGenerator _keyGenerator;
  final ISplitNavigationDelegate _navigationDelegate;

  @override
  void close() {
    _navigationDelegate.removeByKey(_keyGenerator.generateForNewContact());
  }

  @override
  void toDialog({
    String? title,
    required d.Body body,
    List<d.Action> actions = const <d.Action>[],
  }) =>
      _commonScreenRouter.toDialog(title: title, body: body, actions: actions);
}
