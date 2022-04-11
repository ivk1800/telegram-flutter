library showcase;

import 'package:coreui/coreui.dart';
import 'package:flutter/material.dart';
import 'package:showcase/src/showcase_page.dart';

import 'src/showcase/widget/showcase_block_interaction_manager.dart';

export 'src/showcase_page.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

// todo move to scope
final ShowcaseBlockInteractionManager showcaseBlockInteractionManager =
    ShowcaseBlockInteractionManager();

Future<void> launch() async {
  runApp(
    MaterialApp(
      builder: (BuildContext context, Widget? child) {
        return ValueListenableBuilder<bool>(
          child: child,
          valueListenable: showcaseBlockInteractionManager,
          builder: (BuildContext context, bool value, Widget? child) {
            return BlockInteraction(block: value, child: child!);
          },
        );
      },
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
      navigatorKey: navigatorKey,
      title: 'showcase',
      debugShowCheckedModeBanner: false,
      home: const ShowcasePage(),
    ),
  );
}
