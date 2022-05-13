import 'package:flutter/widgets.dart';

class StreamListener<T> extends StatelessWidget {
  const StreamListener({
    super.key,
    required this.stream,
    required this.builder,
  });

  final Stream<T> stream;
  final Widget Function(BuildContext context, T data) builder;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<T>(
      stream: stream,
      builder: (BuildContext context, AsyncSnapshot<T> snapshot) {
        final T? data = snapshot.data;
        if (data != null) {
          return builder.call(context, data);
        }
        return const SizedBox.shrink();
      },
    );
  }
}
