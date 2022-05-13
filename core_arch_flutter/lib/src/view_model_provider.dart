import 'package:core_arch/core_arch.dart';
import 'package:provider/provider.dart';

class ViewModelProvider<T extends BaseViewModel> extends Provider<T> {
  ViewModelProvider({
    super.key,
    required super.create,
    super.child,
  }) : super(
          dispose: (_, T value) => value.dispose(),
          lazy: null,
        );
}
