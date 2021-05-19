import 'package:feature_chats_list_impl/feature_chats_list_impl.dart';
import 'package:feature_main_screen_impl/feature_main_screen_impl.dart';
import 'package:flutter/widgets.dart';
import 'package:presentation/src/page/page.dart';
import 'package:split_view/split_view.dart';
import 'package:jugger/jugger.dart' as j;

import 'navigation.dart';

class MainScreenRouterImpl implements IMainScreenRouter {
  @j.inject
  MainScreenRouterImpl(SplitNavigationInfoProvider splitNavigationInfoProvider,
      KeyGenerator keyGenerator, SplitNavigationRouter navigationRouter)
      : _navigationRouter = navigationRouter,
        _splitNavigationInfoProvider = splitNavigationInfoProvider,
        _keyGenerator = keyGenerator;

  final SplitNavigationInfoProvider _splitNavigationInfoProvider;
  final KeyGenerator _keyGenerator;
  final SplitNavigationRouter _navigationRouter;

  @override
  void toSettings() {
    _navigationRouter.push(
        key: UniqueKey(),
        builder: (BuildContext context) => const ProfilePage(),
        container: ContainerType.Top);
  }
}
