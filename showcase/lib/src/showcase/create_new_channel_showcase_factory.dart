import 'package:block_interaction_api/block_interaction_api.dart';
import 'package:dialog_api/dialog_api.dart' as d;
import 'package:dialog_api_flutter/dialog_api_flutter.dart';
import 'package:fake/fake.dart';
import 'package:feature_create_new_chat_impl/feature_create_new_chat_impl.dart';
import 'package:flutter/widgets.dart';
import 'package:jugger/jugger.dart' as j;
import 'package:localization_api/localization_api.dart';
import 'package:split_view/split_view.dart';
import 'package:tg_logger_api/tg_logger_api.dart';

class CreateNewChannelShowcaseFactory {
  @j.inject
  CreateNewChannelShowcaseFactory({
    required IStringsProvider stringsProvider,
    required IBlockInteractionManager blockInteractionManager,
    required GlobalKey<NavigatorState> navigatorKey,
    required ILogger logger,
  })  : _stringsProvider = stringsProvider,
        _navigatorKey = navigatorKey,
        _logger = logger,
        _blockInteractionManager = blockInteractionManager;

  final IStringsProvider _stringsProvider;
  final ILogger _logger;
  final IBlockInteractionManager _blockInteractionManager;
  final GlobalKey<NavigatorState> _navigatorKey;

  Widget create(BuildContext context) {
    final CreateNewChatFeatureDependencies dependencies =
        CreateNewChatFeatureDependencies(
      errorTransformer: const FakeErrorTransformer(),
      blockInteractionManager: _blockInteractionManager,
      chatManager: FakeChatManager(
        createChannelFunction: (String name, String description) async {
          if (name == 'error') {
            await Future<void>.delayed(const Duration(milliseconds: 200));
            throw Exception('invalid name');
          }
          return Future<void>.delayed(const Duration(milliseconds: 1000))
              .then((_) {
            return 0;
          });
        },
      ),
      router: _Router(
        logger: _logger,
        splitView: SplitView.of(context),
        dialogNavigatorKey: _navigatorKey,
      ),
      stringsProvider: _stringsProvider,
    );
    final CreateNewChatFeature feature = CreateNewChatFeature(
      dependencies: dependencies,
    );

    return feature.createNewChannelScreenFactory.create();
  }
}

class _Router implements ICreateNewChatRouter {
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
  void toCreateNewChannel() {}

  @override
  void toCreateNewGroup() {}

  @override
  void toCreateNewSecretChat() {}

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
  void closeAfterCreateChannel(int chatId) {
    _splitView.removeUntil(ContainerType.top, (_) => false);
  }
}
