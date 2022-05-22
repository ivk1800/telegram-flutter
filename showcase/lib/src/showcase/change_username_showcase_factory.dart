import 'package:block_interaction_api/block_interaction_api.dart';
import 'package:dialog_api/dialog_api.dart' as d;
import 'package:dialog_api_flutter/dialog_api_flutter.dart';
import 'package:fake/fake.dart';
import 'package:feature_change_username_impl/feature_change_username_impl.dart';
import 'package:flutter/widgets.dart';
import 'package:jugger/jugger.dart' as j;
import 'package:localization_api/localization_api.dart';
import 'package:split_view/split_view.dart';
import 'package:tdlib/td_api.dart' as td;
import 'package:tg_logger_api/tg_logger_api.dart';

@j.singleton
class ChangeUsernameShowcaseFactory {
  @j.inject
  ChangeUsernameShowcaseFactory({
    required IStringsProvider stringsProvider,
    required IBlockInteractionManager blockInteractionManager,
    required GlobalKey<NavigatorState> navigatorKey,
    required ILogger logger,
  })  : _stringsProvider = stringsProvider,
        _navigatorKey = navigatorKey,
        _logger = logger,
        _blockInteractionManager = blockInteractionManager;

  final IStringsProvider _stringsProvider;
  final IBlockInteractionManager _blockInteractionManager;
  final GlobalKey<NavigatorState> _navigatorKey;
  final ILogger _logger;

  Widget create(BuildContext context) {
    final FakeTdFunctionExecutor fakeTdFunctionExecutor =
        FakeTdFunctionExecutor(
      resultFactory: (td.TdFunction object) async {
        if (object is td.CreatePrivateChat) {
          return createFakeChat();
        }

        if (object is td.SetUsername) {
          return const td.Ok();
        }

        if (object is td.CheckChatUsername) {
          await Future<dynamic>.delayed(const Duration(milliseconds: 300));
          switch (object.username) {
            case 'taken':
              {
                return const td.CheckChatUsernameResultUsernameOccupied();
              }
            case 'invalid':
              {
                return const td.CheckChatUsernameResultUsernameInvalid();
              }
          }
          return const td.CheckChatUsernameResultOk();
        }
        throw Exception('not handled $object');
      },
    );
    final ChangeUsernameFeatureDependencies dependencies =
        ChangeUsernameFeatureDependencies(
      userRepository: FakeUserRepository(
        fakeUserProvider: const FakeUserProvider(),
      ),
      optionManager: FakeOptionsManager(
        functionExecutor: fakeTdFunctionExecutor,
      ),
      functionExecutor: fakeTdFunctionExecutor,
      errorTransformer: const FakeErrorTransformer(),
      connectionStateProvider: const FakeConnectionStateProvider(
        unstable: true,
      ),
      router: _Router(
        logger: _logger,
        splitView: SplitView.of(context),
        dialogNavigatorKey: _navigatorKey,
      ),
      blockInteractionManager: _blockInteractionManager,
      stringsProvider: _stringsProvider,
    );
    final ChangeUsernameFeature feature = ChangeUsernameFeature(
      dependencies: dependencies,
    );

    return feature.changeUsernameScreenFactory.create();
  }
}

class _Router implements IChangeUsernameRouter {
  _Router({
    required SplitViewState splitView,
    required GlobalKey<NavigatorState> dialogNavigatorKey,
    required ILogger logger,
  })  : _dialogRouterImpl = DialogRouterImpl(
          logger: logger,
          dialogNavigatorKey: dialogNavigatorKey,
        ),
        _splitView = splitView;

  final SplitViewState _splitView;
  final DialogRouterImpl _dialogRouterImpl;

  @override
  void toDialog({
    String? title,
    required d.Body body,
    List<d.Action> actions = const <d.Action>[],
  }) =>
      _dialogRouterImpl.toDialog(
        body: body,
        title: title,
        actions: actions,
      );

  @override
  void close() {
    _splitView.removeUntil(ContainerType.top, (_) => false);
  }
}
