import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import 'base_view_model.dart';

class ViewModelProvider<T extends BaseViewModel> extends Provider<T> {
  ViewModelProvider({
    Key? key,
    required Create<T> create,
    Widget? child,
  }) : super(
          key: key,
          create: create,
          dispose: (_, T value) => value.dispose(),
          child: child,
          lazy: null,
        );
}
