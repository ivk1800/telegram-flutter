import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';

import 'src/scope_generator.dart';

Builder scopeGenerator(BuilderOptions options) {
  return LibraryBuilder(
    ScopeGenerator(),
    generatedExtension: '.scope.dart',
  );
}
