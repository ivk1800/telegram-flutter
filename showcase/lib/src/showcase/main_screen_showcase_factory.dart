import 'package:fake/fake.dart';
import 'package:feature_main_screen_impl/feature_main_screen_impl.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:jugger/jugger.dart' as j;
import 'package:localization_api/localization_api.dart';
import 'package:tdlib/td_api.dart' as td;
import 'package:theme_manager_flutter/theme_manager_flutter.dart';

class MainScreenShowcaseFactory {
  @j.inject
  MainScreenShowcaseFactory({
    required IStringsProvider stringsProvider,
  }) : _stringsProvider = stringsProvider;

  final IStringsProvider _stringsProvider;

  Widget create(BuildContext context) {
    final FakeTdFunctionExecutor fakeTdFunctionExecutor =
        FakeTdFunctionExecutor(
      resultFactory: (td.TdFunction object) {
        throw Exception('todo');
      },
    );

    final MainScreenFeatureDependencies dependencies =
        MainScreenFeatureDependencies(
      chatFilterRepository: FakeChatFilterRepository(
        chatFilters: Stream<List<td.ChatFilterInfo>>.value(
          <td.ChatFilterInfo>[
            const td.ChatFilterInfo(
              id: 1,
              title: 'test',
              iconName: 'All',
            ),
            const td.ChatFilterInfo(
              id: 2,
              title: 'test2',
              iconName: 'All',
            ),
            const td.ChatFilterInfo(
              id: 3,
              title: 'test3',
              iconName: 'All',
            ),
          ],
        ),
      ),
      chatsListScreenFactory: const FakeChatsListScreenFactory(),
      globalSearchScreenFactory: const FakeGlobalSearchScreenFactory(),
      connectionStateProvider:
          const FakeConnectionStateProvider(unstable: true),
      router: const _Router(),
      stringsProvider: _stringsProvider,
      userRepository: FakeUserRepository(
        fakeUserProvider: const FakeUserProvider(),
      ),
      themeManager: ThemeManager(),
      optionsManager: FakeOptionsManager(
        functionExecutor: fakeTdFunctionExecutor,
      ),
      fileRepository: const FakeFileRepository(),
    );

    final MainScreenFeature feature = MainScreenFeature(
      dependencies: dependencies,
    );
    return feature.mainScreenFactory.create();
  }
}

class _Router implements IMainScreenRouter {
  const _Router();

  @override
  void toContacts() {}

  @override
  void toCreateNewChat() {}

  @override
  void toDev() {}

  @override
  void toSettings() {}
}
