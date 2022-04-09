import 'package:app/src/widget/block_interaction_manager.dart';
import 'package:coreui/coreui.dart';
import 'package:flutter/material.dart';
import 'package:split_view/split_view.dart';

import 'tg_theme.dart';

class TgApp extends StatelessWidget {
  const TgApp({
    Key? key,
    required this.blockInteractionManager,
  }) : super(key: key);

  final BlockInteractionManager blockInteractionManager;

  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();
  static final GlobalKey<SplitViewState> splitViewNavigatorKey =
      GlobalKey<SplitViewState>();

  @override
  Widget build(BuildContext context) {
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
      theme: ThemeData(
        pageTransitionsTheme: const PageTransitionsTheme(
          builders: <TargetPlatform, PageTransitionsBuilder>{
            TargetPlatform.android: CupertinoPageTransitionsBuilder(),
          },
        ),
        platform: TargetPlatform.android,
        primaryColor: const Color(0xff5682a3),
        colorScheme: ThemeData.light().colorScheme.copyWith(
              secondary: const Color(0xff598fba),
            ),
        appBarTheme: const AppBarTheme(
          color: Color(0xff5682a3),
        ),
      ),
      home: Container(
        // TODO maybe add color property to SplitView?
        color: Theme.of(context).scaffoldBackgroundColor,
        child: SplitView(
          delegate: const DefaultSplitViewDelegate(),
          key: TgApp.splitViewNavigatorKey,
        ),
      ),
    );
  }
}
