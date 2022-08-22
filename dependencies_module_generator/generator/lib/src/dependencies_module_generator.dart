import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:build/build.dart';
import 'package:dmg_annotation/dmg_annotation.dart';
import 'package:source_gen/source_gen.dart';

import 'dmg_delegate.dart';

class DependenciesModuleGenerator extends GeneratorForAnnotation<Dependencies> {
  @override
  Future<String> generateForAnnotatedElement(
    Element element,
    ConstantReader annotation,
    BuildStep buildStep,
  ) async {
    final ConstantReader? scopeReader = annotation.peek('scope');
    final DartType? scopeType;
    if (scopeReader == null || scopeReader.isNull) {
      scopeType = null;
    } else {
      scopeType = scopeReader.typeValue;
    }
    // TODO check scope type, must be with public constructor
    return DmgDelegate().generateForAnnotatedElement(
      element: element as ClassElement,
      scopeType: scopeType,
    );
  }
}
