import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';

import 'src/dependencies_module_generator.dart';

/// Builds generators for `build_runner` to run
Builder dmg(BuilderOptions options) {
  return LibraryBuilder(
    DependenciesModuleGenerator(),
    generatedExtension: '.dmg.dart',
  );
}
