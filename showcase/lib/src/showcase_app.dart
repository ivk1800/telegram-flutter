import 'package:coreui/coreui.dart';
import 'package:flutter/material.dart';
import 'package:showcase/src/showcase_feature.dart';

class ShowcaseAppFactory {
  final ShowcaseFeature showcase;

  ShowcaseAppFactory(this.showcase);

  Widget create() {
    return MaterialApp(
      builder: (BuildContext context, Widget? child) {
        return ValueListenableBuilder<bool>(
          child: child,
          valueListenable: showcase.showcaseBlockInteractionManager,
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
      navigatorKey: showcase.navigationKey,
      title: 'showcase',
      debugShowCheckedModeBanner: false,
      home: showcase.showcaseScreenFactory.create(),
    );
  }
}
