import 'package:flutter/widgets.dart';
import 'package:jugger/jugger.dart' as j;

import 'circular_progress_widget_page.dart';

class CircularProgressWidgetShowcaseFactory {
  @j.inject
  const CircularProgressWidgetShowcaseFactory();

  Widget create(BuildContext context) {
    return const CircularProgressWidgetPage();
  }
}
