import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:scope_generator_annotation/scope_generator_annotation.dart';
import 'package:source_gen/source_gen.dart';

import 'generator_delegate.dart';

class ScopeGenerator extends GeneratorForAnnotation<Scope> {
  @override
  Future<String> generateForAnnotatedElement(
    Element element,
    ConstantReader annotation,
    BuildStep buildStep,
  ) async {
    return GeneratorDelegate()
        .generateForAnnotatedElement(element as ClassElement);
  }
}
