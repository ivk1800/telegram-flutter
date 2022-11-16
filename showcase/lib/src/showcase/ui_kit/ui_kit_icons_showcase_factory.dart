import 'package:flutter/widgets.dart';
import 'package:jugger/jugger.dart' as j;
import 'ui_kit_icons_showcase_page.dart';

class UiKitIconsShowcaseFactory {
  @j.inject
  const UiKitIconsShowcaseFactory();

  Widget create(BuildContext context) {
    return const UiKitIconsShowcasePage();
  }
}
