// ignore_for_file: do_not_use_environment
import 'package:app/app.dart' as app;
import 'package:showcase/showcase.dart' as showcase;

Future<void> main(List<String> arguments) async {
  if (const String.fromEnvironment('mode') == 'showcase') {
    await showcase.launch();
  } else {
    await app.launch();
  }
}
