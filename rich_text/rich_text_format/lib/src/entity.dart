import 'type.dart';

class Entity {
  Entity({
    required this.text,
    required this.types,
  });

  final String text;
  final List<Type> types;
}
