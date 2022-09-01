// ignore_for_file: cascade_invocations

import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:analyzer/dart/element/visitor.dart';
import 'package:code_builder/code_builder.dart';

class GeneratorDelegate {
  final Allocator _allocator = Allocator.simplePrefixing();

  final Reference baseScopeRef = refer(
    'BaseScope',
    'package:core_arch_flutter/core_arch_flutter.dart',
  );

  Future<String> generateForAnnotatedElement(ClassElement element) async {
    final LibraryBuilder target = LibraryBuilder();

    target.body.add(_buildScopeClass(element));
    target.body.add(_buildScopeDelegateClass(element));

    final DartEmitter dartEmitter = DartEmitter(allocator: _allocator);
    return target.build().accept(dartEmitter).toString();
  }

  Class _buildScopeClass(ClassElement delegateClassElement) {
    return Class((ClassBuilder builder) {
      final _PropertiesVisitor visitor = _PropertiesVisitor();

      delegateClassElement.visitChildren(visitor);

      for (final MethodElement method in visitor.methods) {
        builder.methods.add(_buildStaticMethod(method));
      }

      final int start = delegateClassElement.name.indexOf('I') + 1;
      final int end = delegateClassElement.name.indexOf('Delegate');

      final String className = delegateClassElement.name.substring(start, end);
      builder.name = className;
      builder.extend = refer('${_allocator.allocate(baseScopeRef)}<_Delegate>');
      builder.constructors.add(
        Constructor(
          (ConstructorBuilder builder) {
            builder.optionalParameters.add(
              Parameter((ParameterBuilder builder) {
                builder.name = 'key';
                builder.type = refer('Key?', 'package:flutter/widgets.dart');
              }),
            );
            builder.optionalParameters.add(
              Parameter((ParameterBuilder builder) {
                builder.required = true;
                builder.named = true;
                builder.name = 'child';
                builder.type = refer('Widget', 'package:flutter/widgets.dart');
              }),
            );
            final String delegateClass =
                _allocator.allocate(_allocate(delegateClassElement.thisType));
            builder.optionalParameters.add(
              Parameter((ParameterBuilder builder) {
                builder.required = true;
                builder.named = true;
                builder.name = 'create';
                builder.type = refer('$delegateClass Function()');
              }),
            );
            builder.initializers.add(
              // TODO build with classes
              Code(
                '''
                super(
          key: key,
          child: child,
          create: () {
            final $delegateClass scope = create.call();
            return _Delegate(scope, scope);
          },
        )
''',
              ),
            );
          },
        ),
      );
    });
  }

  Class _buildScopeDelegateClass(ClassElement delegateClassElement) {
    return Class((ClassBuilder builder) {
      builder.name = '_Delegate';
      builder.extend = refer(
        'ScopeDelegate',
        'package:core_arch_flutter/core_arch_flutter.dart',
      );
      final _PropertiesVisitor visitor = _PropertiesVisitor();

      delegateClassElement.visitChildren(visitor);

      for (final MethodElement method in visitor.methods) {
        builder.fields.add(_buildField(method));
      }
      builder.fields.add(
        Field(
          (FieldBuilder builder) {
            builder.modifier = FieldModifier.final$;
            builder.type = refer(
              'ScopeDisposer',
              'package:core_arch_flutter/core_arch_flutter.dart',
            );
            builder.name = '_disposer';
          },
        ),
      );
      builder.fields.add(
        Field(
          (FieldBuilder builder) {
            builder.modifier = FieldModifier.final$;
            builder.type = _allocate(delegateClassElement.thisType);
            builder.name = '_delegate';
          },
        ),
      );
      builder.constructors.add(
        Constructor(
          (ConstructorBuilder builder) {
            builder.requiredParameters.add(
              Parameter((ParameterBuilder builder) {
                builder.toThis = true;
                builder.name = '_delegate';
              }),
            );
            builder.requiredParameters.add(
              Parameter((ParameterBuilder builder) {
                builder.toThis = true;
                builder.name = '_disposer';
              }),
            );
          },
        ),
      );
      builder.methods.add(
        Method((MethodBuilder builder) {
          builder.annotations.add(refer('override'));
          builder.name = 'onDispose';
          builder.returns = refer('void');

          builder.body = Block.of(
            <Code>[
              Code(
                '${_allocator.allocate(refer('unawaited', 'dart:async'))}(_disposer.dispose());',
              ),
              const Code('super.onDispose();'),
            ],
          );
        }),
      );
    });
  }

  Method _buildStaticMethod(MethodElement method) {
    return Method(
      (MethodBuilder builder) {
        builder.static = true;
        builder.returns = _allocate(method.returnType);
        builder.name = method.name;
        builder.requiredParameters.add(
          Parameter((ParameterBuilder parameterBuilder) {
            parameterBuilder.type = refer(
              _allocator.allocate(
                refer('BuildContext', 'package:flutter/widgets.dart'),
              ),
            );
            parameterBuilder.name = 'context';
          }),
        );
        builder.lambda = true;
        builder.body = Code(
          '${_allocator.allocate(baseScopeRef)}.getScopeDelegate<_Delegate>(context)._${method.returnType.getDisplayString(withNullability: false)}',
        );
      },
    );
  }

  Field _buildField(MethodElement method) {
    return Field(
      (FieldBuilder builder) {
        builder.late = true;
        builder.modifier = FieldModifier.final$;
        builder.type = _allocate(method.returnType);
        builder.name =
            '_${method.returnType.getDisplayString(withNullability: false)}';
        builder.assignment = Code('_delegate.${method.name}()');
      },
    );
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
      // TODO void type not supported
      return _allocateTypeName(type as InterfaceType);
    }).join(',')}>';
  }
}

class _PropertiesVisitor extends RecursiveElementVisitor<dynamic> {
  List<MethodElement> methods = <MethodElement>[];

  @override
  dynamic visitMethodElement(MethodElement element) {
    methods.add(element);
    return null;
  }
}
