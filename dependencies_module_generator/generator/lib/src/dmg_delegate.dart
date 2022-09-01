// ignore_for_file: cascade_invocations
import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:analyzer/dart/element/visitor.dart';
import 'package:code_builder/code_builder.dart';

class DmgDelegate {
  final Allocator _allocator = Allocator.simplePrefixing();

  late final Expression _moduleAnnotation = CodeExpression(
    Code(
      _allocator.allocate(
        const Reference(
          'module',
          'package:jugger/jugger.dart',
        ),
      ),
    ),
  );

  late final Expression _providesAnnotation = CodeExpression(
    Code(
      _allocator.allocate(
        const Reference(
          'provides',
          'package:jugger/jugger.dart',
        ),
      ),
    ),
  );

  DartType? _scopeType;

  late final Expression _scopeExpression = () {
    final DartType? scopeType = _scopeType;
    if (scopeType != null) {
      final Element? element = scopeType.element2;
      return CodeExpression(
        Code(
          _allocator.allocate(
            Reference(
              element!.name,
              element.librarySource!.uri.toString(),
            ),
          ),
        ),
      ).call(<Expression>[]);
    }

    return CodeExpression(
      Code(
        _allocator.allocate(
          const Reference(
            'singleton',
            'package:jugger/jugger.dart',
          ),
        ),
      ),
    );
  }();

  Future<String> generateForAnnotatedElement({
    required ClassElement element,
    DartType? scopeType,
  }) async {
    _scopeType = scopeType;
    final LibraryBuilder target = LibraryBuilder();

    target.body.add(_buildModule(dependenciesClassElement: element));

    final DartEmitter dartEmitter = DartEmitter(allocator: _allocator);
    return target.build().accept(dartEmitter).toString();
  }

  Class _buildModule({
    required ClassElement dependenciesClassElement,
  }) {
    return Class((ClassBuilder builder) {
      final _FieldsVisitor visitor = _FieldsVisitor();

      dependenciesClassElement.visitChildren(visitor);

      for (final FieldElement field in visitor.fields) {
        builder.methods.add(
          _buildProviderMethod(
            field: field,
            dependenciesType: dependenciesClassElement.thisType,
          ),
        );
      }

      builder.annotations.add(_moduleAnnotation);
      builder.name = '${dependenciesClassElement.name}Module';
      builder.abstract = true;
    });
  }

  Method _buildProviderMethod({
    required FieldElement field,
    required DartType dependenciesType,
  }) {
    return Method(
      (MethodBuilder builder) {
        builder.annotations.addAll(
          <Expression>[
            _providesAnnotation,
            _scopeExpression,
          ],
        );
        builder.static = true;
        builder.returns = _allocate(field.type);
        builder.name = 'provide${_capitalize(field.name)}';
        builder.requiredParameters.add(
          Parameter((ParameterBuilder parameterBuilder) {
            parameterBuilder.type = _allocate(dependenciesType);
            parameterBuilder.name = 'dependencies';
          }),
        );
        builder.body = Code('return dependencies.${field.name};');
      },
    );
  }

  String _capitalize(String name) {
    return name[0].toUpperCase() + name.substring(1);
  }

  Reference _allocate(DartType type) {
    return refer(_allocateTypeName(type));
  }

  String _allocateTypeName(DartType t) {
    final InterfaceType type = t as InterfaceType;

    final String name = _allocator.allocate(
      Reference(
        type.element2.name,
        type.element2.librarySource.uri.toString(),
      ),
    );

    if (type.typeArguments.isEmpty) {
      return name;
    }

    return '$name<${type.typeArguments.map((DartType type) {
      return _allocateTypeName(type as InterfaceType);
    }).join(',')}>';
  }
}

class _FieldsVisitor extends RecursiveElementVisitor<dynamic> {
  List<FieldElement> fields = <FieldElement>[];

  @override
  dynamic visitFieldElement(FieldElement element) {
    fields.add(element);
    return null;
  }
}
