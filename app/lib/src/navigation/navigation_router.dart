import 'package:flutter/widgets.dart';
import 'package:split_view/split_view.dart';

abstract class ISplitNavigationDelegate {
  void removeUntil(ContainerType container, bool Function(LocalKey key) test);

  void add({
    required LocalKey key,
    required WidgetBuilder builder,
    required ContainerType container,
  });

  void removeByKey(LocalKey key);
}
