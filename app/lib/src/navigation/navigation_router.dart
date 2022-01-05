import 'package:flutter/widgets.dart';
import 'package:split_view/split_view.dart';

abstract class ISplitNavigationDelegate {
  void pushAllReplacement({
    required LocalKey key,
    required WidgetBuilder builder,
    required ContainerType container,
  });

  void push({
    required LocalKey key,
    required WidgetBuilder builder,
    required ContainerType container,
  });

  void back();
}
