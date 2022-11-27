// ignore_for_file: cascade_invocations

import 'dart:io';

import 'package:code_builder/code_builder.dart';
import 'package:dart_style/dart_style.dart';
import 'package:xml/xml.dart';

void generateStringsProvider(String workDirectory) {
  final File file =
      File('$workDirectory/localization_impl/assets/translations/en.xml');
  final XmlDocument document = XmlDocument.parse(file.readAsStringSync());

  final List<_Item> list =
      document.children[2].children.whereType<XmlElement>().map((XmlNode node) {
    final String stringName = _handleReservedName(node.attributes[0].value);
    final String stringValue = node.children.first.toString();

    final RegExp regExp = RegExp(r'(%[0-9]?\$?s)');

    return _Item(
      name: stringName,
      key: node.attributes[0].value,
      value: stringValue,
      formatted: regExp.hasMatch(stringValue),
    );
  }).toList();

  _generateStringProvider(list, workDirectory);
  _generateTgStringProvider(list, workDirectory);
}

const List<String> _reserved = <String>['Continue'];

String _handleReservedName(String name) {
  if (_reserved.contains(name)) {
    return '$name\$';
  }
  return name;
}

void _generateStringProvider(List<_Item> list, String workDirectory) {
  final DartEmitter emitter = DartEmitter(useNullSafetySyntax: true);
  final LibraryBuilder target = LibraryBuilder();

  target.body.add(
    Class(
      (ClassBuilder builder) {
        builder.name = 'IStringsProvider';
        builder.abstract = true;

        for (final _Item item in list) {
          builder.methods.add(
            Method((MethodBuilder mBuilder) {
              mBuilder.name =
                  item.name[0].toLowerCase() + item.name.substring(1);

              if (item.formatted) {
                mBuilder.requiredParameters.add(
                  Parameter(
                    (ParameterBuilder pBuilder) {
                      pBuilder.name = 'args';
                      pBuilder.type = refer('List<dynamic>');
                    },
                  ),
                );
              } else {
                mBuilder.type = MethodType.getter;
              }
              mBuilder.returns = const Reference('String');
            }),
          );
        }
      },
    ),
  );

  final File stringsProviderFile =
      File('$workDirectory/localization_api/lib/src/strings_provider.dart');
  stringsProviderFile.create();
  stringsProviderFile.writeAsString(
    DartFormatter().format('${target.build().accept(emitter)}'),
  );
}

void _generateTgStringProvider(List<_Item> list, String workDirectory) {
  final DartEmitter emitter = DartEmitter();
  final LibraryBuilder target = LibraryBuilder();
  final Allocator allocator = Allocator.simplePrefixing();

  target.body.add(
    Class(
      (ClassBuilder builder) {
        builder.name = 'TgStringsProvider';
        builder.constructors.add(
          Constructor((ConstructorBuilder cBuilder) {
            cBuilder.requiredParameters.add(
              Parameter((ParameterBuilder pBuilder) {
                pBuilder.name = '_stringGetter';
                pBuilder.toThis = true;
              }),
            );
            cBuilder.requiredParameters.add(
              Parameter((ParameterBuilder pBuilder) {
                pBuilder.name = '_stringFormattedGetter';
                pBuilder.toThis = true;
              }),
            );
          }),
        );

        builder.fields.add(
          Field((FieldBuilder fBuilder) {
            fBuilder.type = refer('String Function(String key)');
            fBuilder.name = '_stringGetter';
            fBuilder.modifier = FieldModifier.final$;
          }),
        );
        builder.fields.add(
          Field((FieldBuilder fBuilder) {
            fBuilder.type =
                refer('String Function(String key, List<dynamic> args)');
            fBuilder.name = '_stringFormattedGetter';
            fBuilder.modifier = FieldModifier.final$;
          }),
        );

        const Reference reference = Reference(
          'IStringsProvider',
          'package:localization_api/localization_api.dart',
        );
        allocator.allocate(reference);
        builder.implements.add(const Reference('IStringsProvider'));

        for (final _Item item in list) {
          builder.methods.add(
            Method((MethodBuilder mBuilder) {
              mBuilder.name =
                  item.name[0].toLowerCase() + item.name.substring(1);
              mBuilder.lambda = true;
              mBuilder.annotations.add(const Reference('override'));

              if (item.formatted) {
                mBuilder.requiredParameters.add(
                  Parameter(
                    (ParameterBuilder pBuilder) {
                      pBuilder.name = 'args';
                      pBuilder.type = refer('List<dynamic>');
                    },
                  ),
                );
              } else {
                mBuilder.type = MethodType.getter;
              }
              mBuilder.returns = const Reference('String');
              if (item.formatted) {
                mBuilder.body = Code("""_getFormatted('${item.key}',args)""");
              } else {
                mBuilder.body = Code("""_get('${item.key}')""");
              }
              // mBuilder.body = Code('constructor');
            }),
          );
        }

        builder.methods.add(
          Method((MethodBuilder mBuilder) {
            mBuilder.name = '_get';
            mBuilder.requiredParameters.add(
              Parameter((ParameterBuilder pBuilder) {
                pBuilder.name = 'key';
                pBuilder.type = const Reference('String');
              }),
            );
            mBuilder.lambda = true;
            mBuilder.returns = const Reference('String');
            mBuilder.body = const Code('_stringGetter.call(key)');
            // mBuilder.body = Code('constructor');
          }),
        );

        builder.methods.add(
          Method((MethodBuilder mBuilder) {
            mBuilder.name = '_getFormatted';
            mBuilder.requiredParameters.add(
              Parameter((ParameterBuilder pBuilder) {
                pBuilder.name = 'key';
                pBuilder.type = const Reference('String');
              }),
            );
            mBuilder.requiredParameters.add(
              Parameter((ParameterBuilder pBuilder) {
                pBuilder.name = 'args';
                pBuilder.type = const Reference('List<dynamic>');
              }),
            );
            mBuilder.lambda = true;
            mBuilder.returns = const Reference('String');
            mBuilder.body =
                const Code('_stringFormattedGetter.call(key, args)');
            // mBuilder.body = Code('CONSTRUCTOR');
          }),
        );
      },
    ),
  );

  final File stringsProviderFile = File(
    '$workDirectory/localization_impl/lib/src/tg_strings_provider.dart',
  );
  stringsProviderFile.create();

  const String imprt =
      """import 'package:localization_api/localization_api.dart';""";

  stringsProviderFile.writeAsString(
    DartFormatter().format('$imprt ${target.build().accept(emitter)}'),
  );
}

class _Item {
  _Item({
    required this.name,
    required this.key,
    required this.value,
    required this.formatted,
  });

  final String value;

  final String key;
  final String name;
  final bool formatted;
}
