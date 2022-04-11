import 'package:dialog_api/dialog_api.dart' as d;
import 'package:dialog_api_flutter/dialog_api_flutter.dart';
import 'package:fake/fake.dart';
import 'package:feature_create_new_chat_impl/feature_create_new_chat_impl.dart';
import 'package:flutter/widgets.dart';
import 'package:localization_api/localization_api.dart';
import 'package:provider/provider.dart';
import 'package:showcase/showcase.dart';
import 'package:split_view/split_view.dart';

class CreateNewChannelShowcaseFactory {
  Widget create(BuildContext context) {
    final ILocalizationManager localizationManager =
        context.read<ILocalizationManager>();

    final CreateNewChatFeatureDependencies dependencies =
        CreateNewChatFeatureDependencies(
      errorTransformer: const FakeErrorTransformer(),
      blockInteractionManager: showcaseBlockInteractionManager,
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
      connectionStateProvider: FakeConnectionStateProvider(),
      router: _Router(
        splitView: SplitView.of(context),
        dialogNavigatorKey: navigatorKey,
      ),
      localizationManager: localizationManager,
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
  })  : _dialogRouterImpl = DialogRouterImpl(
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
    _splitView.removeUntil(ContainerType.top, (PageNode node) => false);
  }
}
