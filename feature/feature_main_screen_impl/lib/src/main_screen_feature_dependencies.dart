import 'package:core/core.dart';
import 'package:core_tdlib_api/core_tdlib_api.dart';
import 'package:feature_chats_list_api/feature_chats_list_api.dart';
import 'package:feature_global_search_api/feature_global_search_api.dart';
import 'package:localization_api/localization_api.dart';
import 'package:theme_manager_api/theme_manager_api.dart';

import 'main_screen_router.dart';

class MainScreenFeatureDependencies {
  const MainScreenFeatureDependencies({
    required this.globalSearchScreenFactory,
    required this.chatsListScreenFactory,
    required this.connectionStateProvider,
    required this.router,
    required this.stringsProvider,
    required this.userRepository,
    required this.themeManager,
    required this.optionsManager,
    required this.fileRepository,
    required this.chatFilterRepository,
  });

  final IGlobalSearchScreenFactory globalSearchScreenFactory;
  final IChatsListScreenFactory chatsListScreenFactory;
  final IConnectionStateProvider connectionStateProvider;
  final IMainScreenRouter router;
  final IStringsProvider stringsProvider;
  final IUserRepository userRepository;
  final IThemeManager themeManager;
  final OptionsManager optionsManager;
  final IFileRepository fileRepository;
  final IChatFilterRepository chatFilterRepository;
}
