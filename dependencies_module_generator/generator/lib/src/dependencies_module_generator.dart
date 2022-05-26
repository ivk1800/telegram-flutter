import 'package:analyzer/dart/element/element.dart';
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
    return DmgDelegate().generateForAnnotatedElement(element as ClassElement);
  }
}
