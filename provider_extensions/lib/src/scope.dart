import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

typedef CreateComponent<T> = T Function();
typedef CreateProviders<T> = List<Provider<dynamic>> Function(T value);

class Scope<T> extends StatelessWidget {
  @Deprecated('use own scope')
  const Scope({
    required this.create,
    required this.providers,
    required this.child,
    super.key,
  });

  final CreateComponent<T> create;
  final CreateProviders<T> providers;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Provider<T>(
      create: (_) => create.call(),
      child: Builder(
        builder: (BuildContext context) => MultiProvider(
          providers: providers.call(context.read<T>()),
          child: child,
        ),
      ),
    );
  }
}
