import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/nullability_suffix.dart';
import 'package:analyzer/dart/element/visitor.dart';
import 'package:build/build.dart';
import 'package:code_builder/code_builder.dart';
import 'package:fwg_annotation/fwg_annotation.dart';
import 'package:source_gen/source_gen.dart' hide LibraryBuilder;

class FactoryWidgetGenerator extends GeneratorForAnnotation<WidgetFactory> {
  @override
  Future<String> generateForAnnotatedElement(
    Element element,
    ConstantReader annotation,
    BuildStep buildStep,
  ) async =>
      _generate(element as ClassElement);

  Future<String> _generate(ClassElement factoryClass) async {
    final LibraryBuilder target = LibraryBuilder();
    final int factoryIndex = factoryClass.name.indexOf('Factory');
    final String widgetName = factoryClass.name.substring(0, factoryIndex);

    final _CreateMethodVisitor createMethodVisitor = _CreateMethodVisitor();
    factoryClass.visitChildren(createMethodVisitor);

    assert(createMethodVisitor.createMethod != null);
    final List<ParameterElement> parameters = createMethodVisitor
        .createMethod!.parameters
        .where((ParameterElement parameter) => parameter.name != 'context')
        .toList(growable: false);

    target.body.add(_buildWidgetClass(widgetName, factoryClass, parameters));
    target.body.add(_buildStateClass(widgetName, factoryClass, parameters));

    final DartEmitter dartEmitter = DartEmitter();
    return target.build().accept(dartEmitter).toString();
  }

  Class _buildWidgetClass(
    String widgetName,
    ClassElement factoryClass,
    List<ParameterElement> parameters,
  ) =>
      Class((ClassBuilder builder) {
        builder.constructors.add(_createWidgetClassConstructor(parameters));
        builder.fields.add(_createFactoryField(factoryClass));
        builder.fields.addAll(
          parameters.map(
            (ParameterElement parameter) => Field((FieldBuilder builder) {
              builder
                ..name = parameter.name
                ..type = refer(
                  parameter.type.getDisplayString(withNullability: true),
                )
                ..modifier = FieldModifier.final$;
            }),
          ),
        );
        builder.methods.add(_createCreateStateMethod(widgetName));
        builder
          ..name = widgetName
          ..extend = refer('StatefulWidget');
      });

  Constructor _createWidgetClassConstructor(
    List<ParameterElement> parameters,
  ) =>
      Constructor((ConstructorBuilder builder) {
        builder.constant = true;
        builder.optionalParameters.add(
          Parameter((ParameterBuilder builder) {
            builder
              ..name = 'key'
              ..toSuper = true
              ..named = true;
          }),
        );
        builder.optionalParameters.add(
          Parameter((ParameterBuilder builder) {
            builder
              ..name = 'factory'
              ..toThis = true
              ..named = true
              ..required = true;
          }),
        );
        builder.optionalParameters.addAll(
          parameters.map(
            (ParameterElement parameter) =>
                Parameter((ParameterBuilder builder) {
              builder
                ..name = parameter.name
                ..toThis = true
                ..named = true
                ..required =
                    parameter.type.nullabilitySuffix == NullabilitySuffix.none;
            }),
          ),
        );
      });

  Field _createFactoryField(ClassElement factoryClass) =>
      Field((FieldBuilder builder) {
        builder
          ..name = 'factory'
          ..type = refer(factoryClass.displayName)
          ..modifier = FieldModifier.final$;
      });

  Method _createCreateStateMethod(String widgetName) => Method(
        (MethodBuilder builder) {
          builder.name = 'createState';
          builder.annotations.add(const CodeExpression(Code('override')));
          builder
            ..returns = refer('State<$widgetName>')
            ..lambda = true
            ..body = Code('_${widgetName}State()');
        },
      );

  Class _buildStateClass(
    String widgetName,
    ClassElement factoryClass,
    List<ParameterElement> parameters,
  ) =>
      Class((ClassBuilder builder) {
        builder
          ..name = '_${widgetName}State'
          ..extend = refer('State<$widgetName>');
        builder.fields.add(_createChildField());
        builder.methods.add(
          _createDidUpdateWidgetMethod(parameters, widgetName),
        );
        builder.methods.add(_createBuildMethod());
        builder.methods.add(
          _createCreateChildMethod(parameters, widgetName),
        );
      });

  Method _createCreateChildMethod(
    List<ParameterElement> parameters,
    String widgetName,
  ) =>
      Method(
        (MethodBuilder builder) {
          builder
            ..name = '_createChild'
            ..returns = refer('Widget')
            ..body = Block.of(<Code>[
              const Code('return widget.factory.create('),
              const Code('context,'),
              Code(
                parameters.map((ParameterElement parameter) {
                  return '${parameter.name}:widget.${parameter.name}';
                }).join(','),
              ),
              const Code(',);'),
            ]);
          builder.requiredParameters.add(
            Parameter((ParameterBuilder builder) {
              builder
                ..name = 'widget'
                ..type = refer(widgetName);
            }),
          );
        },
      );

  Method _createBuildMethod() => Method(
        (MethodBuilder builder) {
          //@override
          //   State<AvatarWidget2> createState() => _AvatarWidget2State();
          builder.name = 'build';
          builder.annotations.add(const CodeExpression(Code('override')));
          builder
            ..returns = refer('Widget')
            ..lambda = true
            ..body = const Code('_child');
          builder.requiredParameters.add(
            Parameter((ParameterBuilder builder) {
              builder
                ..name = 'context'
                ..type = refer('BuildContext');
            }),
          );
        },
      );

  Method _createDidUpdateWidgetMethod(
    List<ParameterElement> parameters,
    String widgetName,
  ) =>
      Method(
        (MethodBuilder builder) {
          //@override
          //   State<AvatarWidget2> createState() => _AvatarWidget2State();
          builder.name = 'didUpdateWidget';
          builder.annotations.add(const CodeExpression(Code('override')));
          builder
            ..returns = refer('void')
            ..body = Block.of(<Code>[
              const Code('super.didUpdateWidget(oldWidget);'),
              const Code('if('),
              Code(
                parameters.map((ParameterElement parameter) {
                  return 'oldWidget.${parameter.name} != widget.${parameter.name}';
                }).join(' || '),
              ),
              const Code(') {'),
              const Code('_child = _createChild(widget);'),
              const Code('}'),
            ]);
          builder.requiredParameters.add(
            Parameter((ParameterBuilder builder) {
              builder
                ..name = 'oldWidget'
                ..covariant = true
                ..type = refer(widgetName);
            }),
          );
        },
      );

  Field _createChildField() => Field(
        (FieldBuilder builder) {
          builder
            ..name = '_child'
            ..late = true
            ..type = refer('Widget')
            ..assignment = const Code('_createChild(widget)');
        },
      );
}

class _CreateMethodVisitor extends SimpleElementVisitor<dynamic> {
  MethodElement? createMethod;

  @override
  dynamic visitMethodElement(MethodElement element) {
    if (element.name == 'create') {
      createMethod = element;
    }
    return super.visitMethodElement(element);
  }
}
