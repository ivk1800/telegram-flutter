import 'package:block_interaction_api/block_interaction_api.dart';
import 'package:dialog_api/dialog_api.dart' as d;
import 'package:dialog_api_flutter/dialog_api_flutter.dart';
import 'package:fake/fake.dart';
import 'package:feature_new_contact_impl/feature_new_contact_impl.dart';
import 'package:flutter/widgets.dart';
import 'package:jugger/jugger.dart' as j;
import 'package:localization_api/localization_api.dart';
import 'package:split_view/split_view.dart';
import 'package:tdlib/td_api.dart' as td;
import 'package:tg_logger_api/tg_logger_api.dart';

class NewContactShowcaseFactory {
  @j.inject
  NewContactShowcaseFactory({
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
    final NewContactFeatureDependencies dependencies =
        NewContactFeatureDependencies(
      errorTransformer: const FakeErrorTransformer(),
      fileDownloader: const FakeFileDownloader(),
      userRepository: FakeUserRepository(
        fakeUserProvider: const FakeUserProvider(),
      ),
      connectionStateProvider: const FakeConnectionStateProvider(),
      router: _Router(
        logger: _logger,
        splitView: SplitView.of(context),
        dialogNavigatorKey: _navigatorKey,
      ),
      blockInteractionManager: _blockInteractionManager,
      stringsProvider: _stringsProvider,
      contactsManager: FakeContactsManager(
        addContactCallback: (td.Contact contact, bool sharePhoneNumber) async {
          if (contact.lastName == 'error') {
            await Future<void>.delayed(const Duration(milliseconds: 200));
            throw Exception('invalid lastname');
          }
          return Future<void>.delayed(const Duration(milliseconds: 500));
        },
      ),
    );
    final NewContactFeature feature = NewContactFeature(
      dependencies: dependencies,
    );

    return feature.newContactScreenFactory.create(0);
  }
}

class _Router implements INewContactRouter {
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
