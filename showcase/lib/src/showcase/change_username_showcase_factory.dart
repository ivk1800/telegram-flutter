import 'package:dialog_api/dialog_api.dart' as d;
import 'package:dialog_api_flutter/dialog_api_flutter.dart';
import 'package:fake/fake.dart';
import 'package:feature_change_username_impl/feature_change_username_impl.dart';
import 'package:flutter/widgets.dart';
import 'package:localization_api/localization_api.dart';
import 'package:provider/provider.dart';
import 'package:showcase/showcase.dart';
import 'package:split_view/split_view.dart';
import 'package:tdlib/td_api.dart' as td;

class ChangeUsernameShowcaseFactory {
  Widget create(BuildContext context) {
    final ILocalizationManager localizationManager =
        context.read<ILocalizationManager>();

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
        splitView: SplitView.of(context),
        dialogNavigatorKey: navigatorKey,
      ),
      blockInteractionManager: showcaseBlockInteractionManager,
      stringsProvider: localizationManager.stringsProvider,
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
  })  : _dialogRouterImpl = DialogRouterImpl(
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
