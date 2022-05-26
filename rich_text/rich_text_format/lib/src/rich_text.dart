import 'entity.dart';
import 'type.dart';

class RichText {
  const RichText({
    required this.entities,
  });

  final List<Entity> entities;

  factory RichText.planeText(String text) {
    return RichText(entities: <Entity>[
      Entity(text: text, types: <Type>[Type.planeText()])
    ]);
  }
}
