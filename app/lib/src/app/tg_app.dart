import 'package:app/src/widget/block_interaction_manager.dart';
import 'package:coreui/coreui.dart';
import 'package:flutter/material.dart';
import 'package:split_view/split_view.dart';
import 'package:theme_manager_flutter/theme_manager_flutter.dart' as th;

import 'tg_theme.dart';

class TgApp extends StatelessWidget {
  const TgApp({
    super.key,
    required this.themeManager,
    required this.themeDataResolver,
    required this.blockInteractionManager,
  });

  final BlockInteractionManager blockInteractionManager;
  final th.ThemeManager themeManager;
  final th.ThemeDataResolver themeDataResolver;

  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();
  static final GlobalKey<SplitViewState> splitViewNavigatorKey =
      GlobalKey<SplitViewState>();

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<th.Theme>(
      valueListenable: themeManager,
      builder: (BuildContext context, th.Theme theme, Widget? child) {
        return MaterialApp(
          builder: (BuildContext context, Widget? child) {
            return ValueListenableBuilder<bool>(
              child: child,
              valueListenable: blockInteractionManager,
              builder: (BuildContext context, bool value, Widget? child) {
                return BlockInteraction(
                  block: value,
                  child: TgAppTheme(child: child!),
                );
              },
            );
          },
          debugShowCheckedModeBanner: false,
          navigatorKey: TgApp.navigatorKey,
          theme: themeDataResolver.resolve(theme),
          home: ColoredBox(
            // TODO maybe add color property to SplitView?
            color: Theme.of(context).scaffoldBackgroundColor,
            child: SplitView(
              delegate: const DefaultSplitViewDelegate(),
              key: TgApp.splitViewNavigatorKey,
            ),
          ),
        );
      },
    );
  }
}
