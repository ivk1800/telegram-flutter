import 'package:rich_text_format/rich_text_format.dart';
import 'package:td_api/td_api.dart' as td;

class Parser {
  const Parser();

  List<Entity> parse(td.FormattedText formattedText) {
    if (formattedText.entities.isEmpty) {
      return <Entity>[
        Entity(
          text: formattedText.text,
          types: const <Type>[
            Type.planeText(),
          ],
        )
      ];
    }

    final List<Entity> _entities = <Entity>[];

    final List<td.TextEntity> entities = formattedText.entities
        .where(
          (td.TextEntity element) =>
              element.type.getConstructor() ==
              td.TextEntityTypeTextUrl.constructor,
        )
        .toList();

    if (entities.isEmpty) {
      return <Entity>[
        Entity(
          text: formattedText.text,
          types: const <Type>[
            Type.planeText(),
          ],
        )
      ];
    }

    td.TextEntity? prev;

    for (final td.TextEntity e in entities) {
      if (prev != null) {
        if ((prev.offset + prev.length) + 1 < e.offset) {
          _entities.add(
            Entity(
              types: const <Type>[Type.planeText()],
              text: formattedText.text.substring(
                prev.offset + prev.length,
                e.offset,
              ),
            ),
          );
        } else {
          _entities.add(
            Entity(
              types: const <Type>[Type.planeText()],
              text: formattedText.text.substring(
                e.offset,
                e.offset + e.length,
              ),
            ),
          );
        }
      } else if (e.offset > 0) {
        _entities.add(
          Entity(
            types: const <Type>[Type.planeText()],
            text: formattedText.text.substring(
              0,
              e.offset,
            ),
          ),
        );
      }

      _entities.add(
        Entity(
          types: <Type>[_toRichTextType(e.type)],
          text: formattedText.text.substring(
            e.offset,
            e.offset + e.length,
          ),
        ),
      );
      prev = e;
    }

    if (prev != null && prev.offset + prev.length < formattedText.text.length) {
      _entities.add(
        Entity(
          types: const <Type>[Type.planeText()],
          text: formattedText.text
              .substring(prev.offset + prev.length, formattedText.text.length),
        ),
      );
    }

    return _entities;
  }

  Type _toRichTextType(td.TextEntityType type) {
    return type.maybeMap(
      textUrl: (td.TextEntityTypeTextUrl value) {
        return Type.textUrl(url: value.url);
      },
      orElse: () => const Type.planeText(),
    );
  }
}
