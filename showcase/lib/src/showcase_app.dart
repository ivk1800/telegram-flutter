import 'package:coreui/coreui.dart';
import 'package:flutter/material.dart';
import 'package:showcase/src/showcase_feature.dart';
import 'package:theme_manager_api/theme_manager_api.dart' as th;
import 'package:theme_manager_flutter/theme_manager_flutter.dart';

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
      theme: const ThemeDataResolver().resolve(const th.Theme.classic()),
      navigatorKey: showcase.navigationKey,
      title: 'showcase',
      debugShowCheckedModeBanner: false,
      home: showcase.showcaseScreenFactory.create(),
    );
  }
}
