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
          text: 'text url text',
          entities: <td.TextEntity>[
            td.TextEntity(
              type: td.TextEntityTypeTextUrl(url: 'https://pub.dev/'),
              offset: 5,
              length: 3,
            ),
          ],
        ),
      );

      expect(result.length, 3);
      assertEntity(
        entity: result[0],
        text: 'text ',
        types: <Type>[const Type.planeText()],
      );
      assertEntity(
        entity: result[1],
        text: 'url',
        types: <Type>[const Type.textUrl(url: 'https://pub.dev/')],
      );
      assertEntity(
        entity: result[2],
        text: ' text',
        types: <Type>[const Type.planeText()],
      );
    });

    test('single url at start', () {
      final List<Entity> result = parser.parse(
        const td.FormattedText(
          text: 'url text text',
          entities: <td.TextEntity>[
            td.TextEntity(
              type: td.TextEntityTypeTextUrl(url: 'https://pub.dev/'),
              offset: 0,
              length: 3,
            ),
          ],
        ),
      );

      expect(result.length, 2);
      assertEntity(
        entity: result[0],
        text: 'url',
        types: <Type>[const Type.textUrl(url: 'https://pub.dev/')],
      );
      assertEntity(
        entity: result[1],
        text: ' text text',
        types: <Type>[const Type.planeText()],
      );
    });

    test('single url at end', () {
      final List<Entity> result = parser.parse(
        const td.FormattedText(
          text: 'text text url',
          entities: <td.TextEntity>[
            td.TextEntity(
              type: td.TextEntityTypeTextUrl(url: 'https://pub.dev/'),
              offset: 10,
              length: 3,
            ),
          ],
        ),
      );

      expect(result.length, 2);
      assertEntity(
        entity: result[0],
        text: 'text text ',
        types: <Type>[const Type.planeText()],
      );
      assertEntity(
        entity: result[1],
        text: 'url',
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
        types: <Type>[const Type.planeText()],
      );
      assertEntity(
        entity: result[1],
        text: 'defg',
        types: <Type>[const Type.textUrl(url: 'https://pub.dev/')],
      );
      assertEntity(
        entity: result[2],
        text: '\n\nlkmno - ',
        types: <Type>[const Type.planeText()],
      );
      assertEntity(
        entity: result[3],
        text: 'xzy',
        types: <Type>[const Type.textUrl(url: 'https://pub.dev/')],
      );
    });
  });

  group('custom emoji', () {
    test('single custom emoji', () {
      final List<Entity> result = parser.parse(
        const td.FormattedText(
          text: '🔤',
          entities: <td.TextEntity>[
            td.TextEntity(
              type: td.TextEntityTypeCustomEmoji(customEmojiId: 0),
              offset: 0,
              length: 2,
            ),
          ],
        ),
      );

      expect(result.length, 1);
      assertEntity(
        entity: result[0],
        text: '🔤',
        types: <Type>[const Type.customEmoji(customEmojiId: 0)],
      );
    });

    test('tree custom emoji in the row', () {
      final List<Entity> result = parser.parse(
        const td.FormattedText(
          text: '🔤🔤🔤',
          entities: <td.TextEntity>[
            td.TextEntity(
              type: td.TextEntityTypeCustomEmoji(customEmojiId: 0),
              offset: 0,
              length: 2,
            ),
            td.TextEntity(
              type: td.TextEntityTypeCustomEmoji(customEmojiId: 0),
              offset: 2,
              length: 2,
            ),
            td.TextEntity(
              type: td.TextEntityTypeCustomEmoji(customEmojiId: 0),
              offset: 4,
              length: 2,
            ),
          ],
        ),
      );

      expect(result.length, 3);
    });

    test('starts with text and with custom emoji', () {
      final List<Entity> result = parser.parse(
        const td.FormattedText(
          text: '1🔤🔤🔤',
          entities: <td.TextEntity>[
            td.TextEntity(
              type: td.TextEntityTypeCustomEmoji(customEmojiId: 0),
              offset: 1,
              length: 2,
            ),
            td.TextEntity(
              type: td.TextEntityTypeCustomEmoji(customEmojiId: 0),
              offset: 3,
              length: 2,
            ),
            td.TextEntity(
              type: td.TextEntityTypeCustomEmoji(customEmojiId: 0),
              offset: 5,
              length: 2,
            ),
          ],
        ),
      );

      expect(result.length, 4);
      assertEntity(
        entity: result[0],
        text: '1',
        types: <Type>[const Type.planeText()],
      );
      assertEntity(
        entity: result[1],
        text: '🔤',
        types: <Type>[const Type.customEmoji(customEmojiId: 0)],
      );
      assertEntity(
        entity: result[2],
        text: '🔤',
        types: <Type>[const Type.customEmoji(customEmojiId: 0)],
      );
      assertEntity(
        entity: result[3],
        text: '🔤',
        types: <Type>[const Type.customEmoji(customEmojiId: 0)],
      );
    });

    test('custom emoji between text', () {
      final List<Entity> result = parser.parse(
        const td.FormattedText(
          text: '1🔤2',
          entities: <td.TextEntity>[
            td.TextEntity(
              type: td.TextEntityTypeCustomEmoji(customEmojiId: 0),
              offset: 1,
              length: 2,
            ),
          ],
        ),
      );

      expect(result.length, 3);
      assertEntity(
        entity: result[0],
        text: '1',
        types: <Type>[const Type.planeText()],
      );
      assertEntity(
        entity: result[1],
        text: '🔤',
        types: <Type>[const Type.customEmoji(customEmojiId: 0)],
      );
      assertEntity(
        entity: result[2],
        text: '2',
        types: <Type>[const Type.planeText()],
      );
    });

    test('custom emoji on new line', () {
      final List<Entity> result = parser.parse(
        const td.FormattedText(
          text: '🔤\n🔤',
          entities: <td.TextEntity>[
            td.TextEntity(
              type: td.TextEntityTypeCustomEmoji(customEmojiId: 0),
              offset: 0,
              length: 2,
            ),
            td.TextEntity(
              type: td.TextEntityTypeCustomEmoji(customEmojiId: 0),
              offset: 3,
              length: 2,
            ),
          ],
        ),
      );

      expect(result.length, 3);
      assertEntity(
        entity: result[0],
        text: '🔤',
        types: <Type>[const Type.customEmoji(customEmojiId: 0)],
      );
      assertEntity(
        entity: result[1],
        text: '\n',
        types: <Type>[const Type.planeText()],
      );
      assertEntity(
        entity: result[2],
        text: '🔤',
        types: <Type>[const Type.customEmoji(customEmojiId: 0)],
      );
    });
  });
}

void assertEntity({
  required Entity entity,
  required String text,
  List<Type> types = const <Type>[Type.planeText()],
}) {
  expect(entity.text, text);
  for (int i = 0; i > types.length; i++) {
    expect(entity.types[i], types[i]);
  }
}
