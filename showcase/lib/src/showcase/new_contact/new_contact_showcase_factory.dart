import 'package:dialog_api/dialog_api.dart' as d;
import 'package:dialog_api_flutter/dialog_api_flutter.dart';
import 'package:fake/fake.dart';
import 'package:feature_new_contact_impl/feature_new_contact_impl.dart';
import 'package:flutter/widgets.dart';
import 'package:localization_api/localization_api.dart';
import 'package:provider/provider.dart';
import 'package:showcase/showcase.dart';
import 'package:split_view/split_view.dart';
import 'package:tdlib/td_api.dart' as td;

class NewContactShowcaseFactory {
  Widget create(BuildContext context) {
    final ILocalizationManager localizationManager =
        context.read<ILocalizationManager>();

    final NewContactFeatureDependencies dependencies =
        NewContactFeatureDependencies(
      errorTransformer: const FakeErrorTransformer(),
      fileRepository: const FakeFileRepository(),
      userRepository: FakeUserRepository(
        fakeUserProvider: const FakeUserProvider(),
      ),
      connectionStateProvider: const FakeConnectionStateProvider(),
      router: _Router(
        splitView: SplitView.of(context),
        dialogNavigatorKey: navigatorKey,
      ),
      blockInteractionManager: showcaseBlockInteractionManager,
      stringsProvider: localizationManager.stringsProvider,
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
    _splitView.removeUntil(ContainerType.top, (PageNode node) => false);
  }
}
