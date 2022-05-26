import 'package:flutter/widgets.dart';

import 'settings_search_screen_controller.dart';

abstract class ISettingsSearchScreenFactory {
  Widget create(SettingsSearchScreenController controller);
}
