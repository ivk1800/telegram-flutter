import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';

import 'src/factory_widget_generator.dart';

/// Builds generators for `build_runner` to run
Builder fwg(BuilderOptions options) {
  return PartBuilder(
    <Generator>[FactoryWidgetGenerator()],
    '.fwg.dart',
    header: '// ignore_for_file: type=lint',
  );
}
