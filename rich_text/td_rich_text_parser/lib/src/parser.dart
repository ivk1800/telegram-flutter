import 'package:rich_text_format/rich_text_format.dart';
import 'package:td_api/td_api.dart' as td;

class Parser {
  const Parser();

  List<Entity> parse(td.FormattedText formattedText) {
    final String text = formattedText.text;
    final int textLength = text.length;

    if (formattedText.entities.isEmpty) {
      return <Entity>[
        Entity(
          text: text,
          types: <Type>[const Type.planeText()],
        )
      ];
    }

    final List<Entity> _entities = <Entity>[];

    final List<td.TextEntity> supportedEntities = formattedText.entities.where(
      (td.TextEntity element) {
        final String constructor = element.type.getConstructor();
        return constructor == td.TextEntityTypeTextUrl.constructor ||
            constructor == td.TextEntityTypeCustomEmoji.constructor;
      },
    ).toList();

    if (supportedEntities.isEmpty) {
      return <Entity>[
        Entity(
          text: formattedText.text,
          types: const <Type>[Type.planeText()],
        )
      ];
    }

    td.TextEntity? prev;

    for (final td.TextEntity entity in supportedEntities) {
      if (prev == null) {
        if (entity.offset > 0) {
          _entities.add(
            Entity(
              types: <Type>[const Type.planeText()],
              text: text.substring(0, entity.offset),
            ),
          );
        }
      } else {
        if ((prev.offset + prev.length) + 1 <= entity.offset) {
          _entities.add(
            Entity(
              types: <Type>[const Type.planeText()],
              text: text.substring(prev.offset + prev.length, entity.offset),
            ),
          );
        }
      }

      _entities.add(
        Entity(
          types: <Type>[_toRichTextType(entity.type)],
          text: text.substring(entity.offset, entity.offset + entity.length),
        ),
      );
      prev = entity;
    }

    if (prev != null && prev.offset + prev.length < textLength) {
      _entities.add(
        Entity(
          types: <Type>[const Type.planeText()],
          text: text.substring(prev.offset + prev.length, textLength),
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
      customEmoji: (td.TextEntityTypeCustomEmoji value) {
        return Type.customEmoji(customEmojiId: value.customEmojiId);
      },
      orElse: () => const Type.planeText(),
    );
  }
}
