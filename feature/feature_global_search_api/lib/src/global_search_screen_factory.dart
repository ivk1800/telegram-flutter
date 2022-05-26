import 'package:flutter/widgets.dart';

import 'global_search_screen_controller.dart';

abstract class IGlobalSearchScreenFactory {
  Widget create(GlobalSearchScreenController controller);
}
