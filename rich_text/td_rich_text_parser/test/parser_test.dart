import 'package:rich_text_format/rich_text_format.dart';
import 'package:td_api/td_api.dart' as td;
import 'package:td_rich_text_parser/src/parser.dart';
import 'package:test/test.dart';

void main() {
  late Parser parser;

  setUp(() {
    parser = const Parser();
  });

  group('text url', () {
    test('single url in center', () {
      final List<Entity> result = parser.parse(
        const td.FormattedText(
          text: 'hello1 hello 1hello',
          entities: <td.TextEntity>[
            td.TextEntity(
              type: td.TextEntityTypeTextUrl(url: 'https://pub.dev/'),
              offset: 7,
              length: 5,
            ),
          ],
        ),
      );

      expect(3, result.length);
      assertEntity(
        entity: result[0],
        text: 'hello1 ',
      );
      assertEntity(
        entity: result[1],
        text: 'hello',
        types: <Type>[const Type.textUrl(url: 'https://pub.dev/')],
      );
      assertEntity(
        entity: result[2],
        text: ' 1hello',
      );
    });

    test('single url at start', () {
      final List<Entity> result = parser.parse(
        const td.FormattedText(
          text: 'hello hello1 1hello',
          entities: <td.TextEntity>[
            td.TextEntity(
              type: td.TextEntityTypeTextUrl(url: 'https://pub.dev/'),
              offset: 0,
              length: 5,
            ),
          ],
        ),
      );

      expect(result.length, 2);
      assertEntity(
        entity: result[0],
        text: 'hello',
        types: <Type>[const Type.textUrl(url: 'https://pub.dev/')],
      );
      assertEntity(
        entity: result[1],
        text: ' hello1 1hello',
      );
    });

    test('single url at end', () {
      final List<Entity> result = parser.parse(
        const td.FormattedText(
          text: 'hello1 hello1 hello',
          entities: <td.TextEntity>[
            td.TextEntity(
              type: td.TextEntityTypeTextUrl(url: 'https://pub.dev/'),
              offset: 14,
              length: 5,
            ),
          ],
        ),
      );

      expect(result.length, 2);
      assertEntity(
        entity: result[0],
        text: 'hello1 hello1 ',
      );
      assertEntity(
        entity: result[1],
        text: 'hello',
        types: <Type>[const Type.textUrl(url: 'https://pub.dev/')],
      );
    });

    test('two urls', () {
      final List<Entity> result = parser.parse(
        const td.FormattedText(
          text: 'abs\n\ndefg\n\nlkmno - xzy',
          entities: <td.TextEntity>[
            td.TextEntity(
              offset: 5,
              length: 4,
              type: td.TextEntityTypeTextUrl(url: 'https://pub.dev/'),
            ),
            td.TextEntity(
              offset: 19,
              length: 3,
              type: td.TextEntityTypeTextUrl(url: 'https://pub.dev/'),
            ),
          ],
        ),
      );

      expect(result.length, 4);
      assertEntity(
        entity: result[0],
        text: 'abs\n\n',
      );
      assertEntity(
        entity: result[1],
        text: 'defg',
        types: <Type>[const Type.textUrl(url: 'https://pub.dev/')],
      );
      assertEntity(
        entity: result[2],
        text: '\n\nlkmno - ',
      );
      assertEntity(
        entity: result[3],
        text: 'xzy',
        types: <Type>[const Type.textUrl(url: 'https://pub.dev/')],
      );
    });
  });
}

void assertEntity({
  required Entity entity,
  required String text,
  List<Type> types = const <Type>[Type.planeText()],
}) {
  expect(text, entity.text);
  for (int i = 0; i > types.length; i++) {
    expect(entity.types[i], types[i]);
  }
}
