import 'package:app/src/widget/block_interaction_manager.dart';
import 'package:app_controller/app_controller.dart';
import 'package:flutter/widgets.dart';
import 'package:jugger/jugger.dart' as j;
import 'package:theme_manager_flutter/theme_manager_flutter.dart';

import 'tg_app.dart';

class AppLauncher implements IAppLauncher {
  @j.inject
  const AppLauncher({
    required ThemeDataResolver themeDataResolver,
    required ThemeManager themeManager,
    required BlockInteractionManager blockInteractionManager,
  })  : _themeDataResolver = themeDataResolver,
        _themeManager = themeManager,
        _blockInteractionManager = blockInteractionManager;

  final ThemeDataResolver _themeDataResolver;
  final ThemeManager _themeManager;
  final BlockInteractionManager _blockInteractionManager;

  @override
  void launch() {
    final TgApp app = TgApp(
      themeDataResolver: _themeDataResolver,
      themeManager: _themeManager,
      blockInteractionManager: _blockInteractionManager,
    );
    runApp(app);
  }
}
