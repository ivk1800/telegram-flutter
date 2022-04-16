import 'package:async/async.dart';
import 'package:async_utils/async_utils.dart';
import 'package:block_interaction_api/block_interaction_api.dart';
import 'package:core/core.dart';
import 'package:core_arch/core_arch.dart';
import 'package:core_tdlib_api/core_tdlib_api.dart';
import 'package:dialog_api/dialog_api.dart' as d;
import 'package:error_transformer_api/error_transformer_api.dart';
import 'package:feature_change_username_impl/feature_change_username_impl.dart';
import 'package:feature_change_username_impl/src/screen/change_username/change_username_state.dart';
import 'package:feature_change_username_impl/src/screen/username_checker.dart';
import 'package:localization_api/localization_api.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tdlib/td_api.dart' as td;
import 'package:user_info/user_info.dart';

class ChangeUsernameViewModel extends BaseViewModel {
  ChangeUsernameViewModel({
    required IChangeUsernameRouter router,
    required IBlockInteractionManager blockInteractionManager,
    required UsernameChecker usernameChecker,
    required IErrorTransformer errorTransformer,
    required IStringsProvider stringsProvider,
    required UserInfoResolver userInfoResolver,
    required OptionsManager optionsManager,
    required ITdFunctionExecutor functionExecutor,
  })  : _router = router,
        _usernameChecker = usernameChecker,
        _userInfoResolver = userInfoResolver,
        _functionExecutor = functionExecutor,
        _stringsProvider = stringsProvider,
        _optionsManager = optionsManager,
        _errorTransformer = errorTransformer,
        _blockInteractionManager = blockInteractionManager;

  final UsernameChecker _usernameChecker;
  final IBlockInteractionManager _blockInteractionManager;
  final IChangeUsernameRouter _router;
  final IErrorTransformer _errorTransformer;
  final IStringsProvider _stringsProvider;
  final UserInfoResolver _userInfoResolver;
  final OptionsManager _optionsManager;
  final ITdFunctionExecutor _functionExecutor;

  final BehaviorSubject<CheckUsernameState> _stateSubject =
      BehaviorSubject<CheckUsernameState>.seeded(
    const CheckUsernameState.loading(),
  );

  Stream<CheckUsernameState> get state => _stateSubject;

  @override
  void init() {
    super.init();
    _load();
  }

  void _load() {
    final CancelableOperation<String> operation = _optionsManager
        .getMyId()
        .then(_userInfoResolver.resolveAsFuture)
        .then((UserInfo info) => info.user.username)
        .toCancelableOperation()
        .onValue(
      (String username) {
        _stateSubject.add(
          CheckUsernameState.data(
            initialUsername: username,
          ),
        );
      },
    );

    attach(operation);
  }

  void onSaveTap(String username) {
    _setUsername(username);
  }

  @override
  void dispose() {
    _stateSubject.close();
    super.dispose();
  }

  void _setUsername(String username) {
    _blockInteractionManager.setState(active: true);
    final CancelableOperation<void> operation =
        _checkUsernameFuture(username).toCancelableOperation().onTerminate(() {
      _blockInteractionManager.setState(active: false);
    }).then((CheckResult result) {
      return result.map(
        error: (CheckResultError value) =>
            throw Exception(value.textForDisplay),
        ok: (_) =>
            _functionExecutor.send<td.Ok>(td.SetUsername(username: username)),
      );
    }).onValue((void result) {
      _router.close();
    }).onError((Object error) {
      _router.toDialog(
        body: d.Body.text(
          text: _errorTransformer.transformToString(error),
        ),
        actions: <d.Action>[
          d.Action(text: _stringsProvider.oK),
        ],
      );
    });
    attach(operation);
  }

  Future<CheckResult> _checkUsernameFuture(String username) {
    return _usernameChecker.check(username).catchError((Object error) =>
        CheckResult.error(_errorTransformer.transformToString(error)));
  }
}
